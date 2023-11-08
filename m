Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289A87E5EEB
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 21:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjKHUET (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 15:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKHUES (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 15:04:18 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FE7211B
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 12:04:16 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7C15B340069;
        Wed,  8 Nov 2023 20:04:12 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id C98FA13C2B0;
        Wed,  8 Nov 2023 12:04:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C98FA13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1699473850;
        bh=d9x6FV+CWYWKliknqDeS/ocSUN+3HQdFOzo4xIDH1Xo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gyNAfJuhdsKfj+qfTjeB5+EIUII8OuzHQ/ALXFiI2PgaKQz/0Q7YlWIp/3CK65mzW
         SXqgmKx2LcKbWY5Mp1fl3I6NViPKP0lCT1C6LHCjLCSZoCzGut/j/vPmhnZFD99hA+
         L+CvHOHucnp+JmIfZkjKrMP5nM0gUm+v9kLDocis=
Message-ID: <91f66433-7eb9-4916-953e-6587f9ff5944@candelatech.com>
Date:   Wed, 8 Nov 2023 12:04:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: 6.7.0-rc1 + hacks deadlock bug, wifi netdev delete + cat of
 debugfs file.
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Nicolai Stange <nicstange@gmail.com>
References: <56d0b043-0585-5380-5703-f25d9a42f39d@candelatech.com>
 <cb377661e760d7728d11bd155b016f852b2681eb.camel@sipsolutions.net>
 <e8e38526-665d-6a88-b433-6f40b1182b57@candelatech.com>
 <d77c0a76201f77b7e86c2f200d2fea5cb6bffb94.camel@sipsolutions.net>
 <dd6c7cf2-1955-4c70-fd2f-ffe2915111f4@candelatech.com>
 <0cfd8ae0577e52fe8db41dbfb37ee5197a1857d6.camel@sipsolutions.net>
 <21a4b983-1d5c-8c76-0994-d8a43285b19d@candelatech.com>
 <6abad7701a110116a49e54f908a9ab9422a8e6ad.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <6abad7701a110116a49e54f908a9ab9422a8e6ad.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1699473854-62vD-CM7aqcv
X-MDID-O: us5;at1;1699473854;62vD-CM7aqcv;<greearb@candelatech.com>;ea9bd3aeb2d9945ea56a779a64e478e9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/8/23 10:43, Johannes Berg wrote:
> On Wed, 2023-11-08 at 09:44 -0800, Ben Greear wrote:
>>
>> This method appears to actually set a S_DEAD flag in the dentry,
>>
> 
> A *dir* entry.
> 
>>   so maybe
>> we just check that flag in the mutex_trylock failed to acquire path
>> in the debugfs read?
>>
>> void simple_recursive_removal(struct dentry *dentry,
>>                                 void (*callback)(struct dentry *))
>> {
>> 	struct dentry *this = dget(dentry);
>> 	while (true) {
>> 		struct dentry *victim = NULL, *child;
>> 		struct inode *inode = this->d_inode;
>>
>> 		inode_lock(inode);
>> 		if (d_is_dir(this))
>> 			inode->i_flags |= S_DEAD;
>>
> 
> But even if you did that, I'm not sure what you'd do? trylock and sleep,
> and abort if you find it's being removed? That all sounds super awkward.

Here is my compile-only tested approach.  It only tries to fix one particular
locking case in debugfs, so I'm sure it is not yet complete.  I believe I
need to add that new flag in the fs.h, as S_DEAD is only for directories,
if I understand the code properly.


diff --git a/fs/libfs.c b/fs/libfs.c
index abe2b5a40ba1..5b420e019ad4 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -520,6 +520,7 @@ void simple_recursive_removal(struct dentry *dentry,
                 inode_lock(inode);
                 if (d_is_dir(this))
                         inode->i_flags |= S_DEAD;
+               inode->i_flags |= S_GOING_AWAY;
                 while ((child = find_next_child(this, victim)) == NULL) {
                         // kill and ascend
                         // update metadata while it's still locked
@@ -530,6 +531,7 @@ void simple_recursive_removal(struct dentry *dentry,
                         this = this->d_parent;
                         inode = this->d_inode;
                         inode_lock(inode);
+                       inode->i_flags |= S_GOING_AWAY;
                         if (simple_positive(victim)) {
                                 d_invalidate(victim);   // avoid lost mounts
                                 if (d_is_dir(victim))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..b76eafe31427 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2116,6 +2116,7 @@ struct super_operations {
  #define S_CASEFOLD     (1 << 15) /* Casefolded file */
  #define S_VERITY       (1 << 16) /* Verity file (using fs/verity/) */
  #define S_KERNEL_FILE  (1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
+#define S_GOING_AWAY   (1 << 18) /* dentry is trying to be deleted */

  /*
   * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -2163,6 +2164,7 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
  #define IS_ENCRYPTED(inode)    ((inode)->i_flags & S_ENCRYPTED)
  #define IS_CASEFOLDED(inode)   ((inode)->i_flags & S_CASEFOLD)
  #define IS_VERITY(inode)       ((inode)->i_flags & S_VERITY)
+#define IS_INODE_GOINGAWAY(inode) ((inode)->i_flags & S_GOING_AWAY)

  #define IS_WHITEOUT(inode)     (S_ISCHR(inode->i_mode) && \
                                  (inode)->i_rdev == WHITEOUT_DEV)
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 34fbefad7652..b4f3bf1c6b19 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5881,6 +5881,33 @@ static inline void wiphy_lock(struct wiphy *wiphy)
         __acquire(&wiphy->mtx);
  }

+/**
+ * wiphy_trylock - try to lock the wiphy
+ * @wiphy: the wiphy to lock
+ *
+ * This is needed around registering and unregistering netdevs that
+ * aren't created through cfg80211 calls, since that requires locking
+ * in cfg80211 when the notifiers is called, but that cannot
+ * differentiate which way it's called.
+ *
+ * It can also be used by drivers for their own purposes.
+ *
+ * When cfg80211 ops are called, the wiphy is already locked.
+ *
+ * Note that this makes sure that no workers that have been queued
+ * with wiphy_queue_work() are running.
+ *
+ * Returns 0 if lock failed, non-zero otherwise.
+ */
+static inline int wiphy_trylock(struct wiphy *wiphy)
+       __acquires(&wiphy->mtx)
+{
+       int rv = mutex_trylock(&wiphy->mtx);
+       if (rv)
+               __acquire(&wiphy->mtx);
+       return rv;
+}
+
  /**
   * wiphy_unlock - unlock the wiphy again
   * @wiphy: the wiphy to unlock
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index ec91e131b29e..c22697969973 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -23,15 +23,31 @@
  #include "driver-ops.h"

  static ssize_t ieee80211_if_read_sdata(
+       struct file* file,
         struct ieee80211_sub_if_data *sdata,
         char __user *userbuf,
         size_t count, loff_t *ppos,
         ssize_t (*format)(const struct ieee80211_sub_if_data *sdata, char *, int))
  {
-       char buf[200];
         ssize_t ret = -EINVAL;
-
-       wiphy_lock(sdata->local->hw.wiphy);
+       struct inode* f_inode;
+       char buf[200];
+       int rv;
+
+       while (true) {
+               rv = wiphy_trylock(sdata->local->hw.wiphy);
+               if (rv) {
+                       break; /* we have the lock */
+               } else {
+                       /* failed to lock, see if we are being deleted. */
+                       f_inode = file_inode(file);
+                       if (IS_INODE_GOINGAWAY(f_inode) || IS_DEADDIR(f_inode)) {
+                               return -ESTALE;
+                       }
+                       /* Sleep for a bit so we don't busy-spin too hard on try-lock */
+                       msleep(1);
+               }
+       }
         ret = (*format)(sdata, buf, sizeof(buf));
         wiphy_unlock(sdata->local->hw.wiphy);

@@ -173,7 +189,7 @@ static ssize_t ieee80211_if_read_##name(struct file *file,          \
                                         char __user *userbuf,           \
                                         size_t count, loff_t *ppos)     \
  {                                                                      \
-       return ieee80211_if_read_sdata(file->private_data,              \
+       return ieee80211_if_read_sdata(file, file->private_data,        \
                                        userbuf, count, ppos,            \
                                        ieee80211_if_fmt_##name);        \
  }

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


