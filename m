Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DB46AAAA5
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Mar 2023 16:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjCDPL2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Mar 2023 10:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCDPL2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Mar 2023 10:11:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E8516321
        for <linux-wireless@vger.kernel.org>; Sat,  4 Mar 2023 07:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677942639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=A1jyIshrRJXdDZu7B4588O6OdU6TI/IkIc6BCPhHzRM=;
        b=EqPThA/APB+yTpBIjNWtKLSFfozJye5DY9KKbx/x1BSDM0YdYZzJ5UEHOFSefohbSe4Ud6
        mM2s1vtjWHhaJ8WX1lShnkdayGvMpCvRHFjAUEa+u2gp2eoDytdpbmfEfxZ8/dCokuaZiV
        /4UWFpmgQXnYvm++5GaRNbk7TGu4uEQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-m0bFtMrlPUC1LpJAeBLXdg-1; Sat, 04 Mar 2023 10:10:38 -0500
X-MC-Unique: m0bFtMrlPUC1LpJAeBLXdg-1
Received: by mail-pl1-f198.google.com with SMTP id ju20-20020a170903429400b0019ea5ea044aso1241028plb.21
        for <linux-wireless@vger.kernel.org>; Sat, 04 Mar 2023 07:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677942637;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1jyIshrRJXdDZu7B4588O6OdU6TI/IkIc6BCPhHzRM=;
        b=tEzyv77lOX+8Ma8p8dzVcwKhqZcflcwABPwyCbYszYGLggNeTQwojdCGzjhA6hNIb6
         3BhFsAA8ZwJ2/Nu16e2CB89LX0qc1MHlAZvlwlekNhCe4S29+vdjxnRzih2Tw8yONapG
         cDp3iJqcQIQ4A1TF1BUFuVMUZqiM5QymziSk3Mr0HHHgWJMIU7Hm4jDBdePNSgt3Z236
         NTRbS9yhk5wDIAFxdTljwydYkb/Xs0l7hnl2f09zvs+ctOTWyFyRd+zao9FY6eWpFAyd
         0EZSPqvC8RMIdugh1gIZGWdYG5aqMR1AJKPfp6VkjDeHoHjZEttf/Q5fS2oN+awN/3ry
         iprA==
X-Gm-Message-State: AO0yUKXekBz5uMC3efabT/E6R55db7p7yC9fsbWGC3++TffUHtyVjpCG
        tj0EkPLNeLD7eZK442EwoC1Ay7pLxOFZi6+k8mj+U2uOgsY1ffmIp99oULPCVF7CYmGTkatgpmA
        cJr0plexzM+q7jGIAo/jtivkmi95ILaErNF0RQcXXEAOyZ3ZycyreNvcSUSg7a+fLvsYf54Dboh
        g5yWfw5bju/Zw=
X-Received: by 2002:a17:90b:4f87:b0:239:e70c:b96f with SMTP id qe7-20020a17090b4f8700b00239e70cb96fmr5859441pjb.41.1677942637145;
        Sat, 04 Mar 2023 07:10:37 -0800 (PST)
X-Google-Smtp-Source: AK7set/HFx2x1h2jknDBAjMaV30oUTG13XDTomETv77ey5GKn6JIaoZXseWVL6cjOwhDJ2HtcX1U8Q==
X-Received: by 2002:a17:90b:4f87:b0:239:e70c:b96f with SMTP id qe7-20020a17090b4f8700b00239e70cb96fmr5859390pjb.41.1677942636318;
        Sat, 04 Mar 2023 07:10:36 -0800 (PST)
Received: from kernel-devel ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id 19-20020a631253000000b004fb171df68fsm3380650pgs.7.2023.03.04.07.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 07:10:35 -0800 (PST)
Date:   Sun, 5 Mar 2023 00:10:31 +0900
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     quic_alokad@quicinc.com, quic_msinada@quicinc.com,
        johannes.berg@intel.com
Subject: WARNING in nla_get_range_unsigned
Message-ID: <ZANfZ6wHQOUObgh4@kernel-devel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Recently, when I ran syzkaller, the following warning was detected:

[   37.446619][ T8620] ------------[ cut here ]------------
[   37.447395][ T8620] WARNING: CPU: 2 PID: 8620 at lib/nlattr.c:118 nla_get_range_unsigned+0x199/0x460
[   37.448059][ T8620] Modules linked in:
[   37.448350][ T8620] CPU: 2 PID: 8620 Comm: repro Not tainted 6.2.0 #1
[   37.448817][ T8620] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc37 04/01/2014
[   37.449485][ T8620] RIP: 0010:nla_get_range_unsigned+0x199/0x460
[   37.449927][ T8620] Code: 0f 85 34 02 00 00 a9 08 00 08 00 0f 85 35 02 00 00 e8 9b 55 37 fd 0f 0b 5b 41 5c 41 5d 41 5e 5d e9 8c 55 37 fd e8 87 55 37 fd <0f> 0b e9 50 4
[   37.451445][ T8620] RSP: 0018:ffffc900132873a0 EFLAGS: 00010293
[   37.451883][ T8620] RAX: 0000000000000000 RBX: ffffffff8b7cff40 RCX: 0000000000000000
[   37.452443][ T8620] RDX: ffff88801f018000 RSI: ffffffff844dde29 RDI: 0000000000000003
[   37.452997][ T8620] RBP: ffffc900132873c0 R08: 0000000000000003 R09: 0000000000000000
[   37.453555][ T8620] R10: 000000000000ffff R11: ffffffff8f9ebb5f R12: ffffc90013287468
[   37.454114][ T8620] R13: ffffffff8b7cff41 R14: 000000000000ffff R15: ffff888022c24614
[   37.454671][ T8620] FS:  00007f32f97ff600(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
[   37.455297][ T8620] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.455764][ T8620] CR2: 00007f32f95c1585 CR3: 000000004d37e000 CR4: 0000000000750ee0
[   37.456320][ T8620] PKRU: 55555554
[   37.456582][ T8620] Call Trace:
[   37.456828][ T8620]  <TASK>
[   37.457050][ T8620]  __nla_validate_parse+0x164e/0x24d0
[   37.457461][ T8620]  ? nla_get_range_signed+0x370/0x370
[   37.457851][ T8620]  ? kasan_unpoison+0x44/0x70
[   37.458199][ T8620]  __nla_parse+0x40/0x50
[   37.458512][ T8620]  genl_family_rcv_msg_attrs_parse.constprop.0+0x19e/0x280
[   37.459025][ T8620]  genl_family_rcv_msg_doit.isra.0+0xa3/0x2e0
[   37.459461][ T8620]  ? genl_start+0x650/0x650
[   37.459790][ T8620]  ? apparmor_capable+0x1da/0x4e0
[   37.460158][ T8620]  ? bpf_lsm_capable+0x9/0x10
[   37.460500][ T8620]  ? security_capable+0x92/0xc0
[   37.460884][ T8620]  ? ns_capable+0xd5/0x110
[   37.461221][ T8620]  genl_rcv_msg+0x4fe/0x7c0
[   37.461552][ T8620]  ? genl_family_rcv_msg_doit.isra.0+0x2e0/0x2e0
[   37.462002][ T8620]  ? nl80211_post_doit+0x2f0/0x2f0
[   37.462378][ T8620]  ? nl80211_assoc_bss+0x260/0x260
[   37.462749][ T8620]  ? nl80211_parse_sta_wme+0x3c0/0x3c0
[   37.463156][ T8620]  netlink_rcv_skb+0x166/0x440
[   37.463506][ T8620]  ? genl_family_rcv_msg_doit.isra.0+0x2e0/0x2e0
[   37.463955][ T8620]  ? netlink_ack+0x1370/0x1370
[   37.464317][ T8620]  genl_rcv+0x28/0x40
[   37.464610][ T8620]  netlink_unicast+0x530/0x800
[   37.464963][ T8620]  ? netlink_attachskb+0x880/0x880
[   37.465339][ T8620]  ? __sanitizer_cov_trace_switch+0x54/0x90
[   37.465764][ T8620]  ? __phys_addr_symbol+0x30/0x70
[   37.467377][ T8620]  ? __check_object_size+0x333/0x6f0
[   37.468983][ T8620]  netlink_sendmsg+0x90b/0xe10
[   37.470566][ T8620]  ? netlink_unicast+0x800/0x800
[   37.472194][ T8620]  ? bpf_lsm_socket_sendmsg+0x9/0x10
[   37.473787][ T8620]  ? netlink_unicast+0x800/0x800
[   37.475357][ T8620]  sock_sendmsg+0xd9/0x180
[   37.476862][ T8620]  ____sys_sendmsg+0x66d/0x910
[   37.478373][ T8620]  ? kernel_sendmsg+0x50/0x50
[   37.479854][ T8620]  ? __copy_msghdr+0x460/0x460
[   37.481366][ T8620]  ? find_held_lock+0x2d/0x110
[   37.482806][ T8620]  ___sys_sendmsg+0x11d/0x1b0
[   37.484179][ T8620]  ? do_recvmmsg+0x700/0x700
[   37.485476][ T8620]  ? lockdep_hardirqs_on_prepare+0x410/0x410
[   37.486756][ T8620]  ? file_tty_write.constprop.0+0x619/0x9f0
[   37.488014][ T8620]  ? n_tty_close+0x1f0/0x1f0
[   37.489163][ T8620]  ? find_held_lock+0x2d/0x110
[   37.490296][ T8620]  ? __fget_light+0x205/0x270
[   37.491424][ T8620]  __sys_sendmsg+0xfa/0x1d0
[   37.492506][ T8620]  ? __sys_sendmsg_sock+0x30/0x30
[   37.493572][ T8620]  ? __audit_syscall_entry+0x396/0x500
[   37.494639][ T8620]  do_syscall_64+0x38/0xb0
[   37.495634][ T8620]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

I investigated this issue and found that the issue relates to the
following commit:

d7c1a9a0ed18 wifi: nl80211: validate and configure puncturing bitmap

This commit sets the maximum value of nla_policy for
NL80211_ATTR_PUNCT_BITMAP to 0xffff as below:

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c82c66c32faa..683adeb3c9e3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -805,6 +805,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
        [NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
        [NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
        [NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
+       [NL80211_ATTR_PUNCT_BITMAP] = NLA_POLICY_RANGE(NLA_U8, 0, 0xffff),
 };

This triggers the warning in nla_get_range_unsigned() below as 0xffff
is interpreted to -1:

void nla_get_range_unsigned(const struct nla_policy *pt,
			    struct netlink_range_validation *range)
{
	WARN_ON_ONCE(pt->validation_type != NLA_VALIDATE_RANGE_PTR &&
		     (pt->min < 0 || pt->max < 0));

I also noticed that checking the value to 0xffff is a bit different in
the following original patch:

https://lore.kernel.org/all/20230131001227.25014-3-quic_alokad@quicinc.com/

So, I tried to modify the code like below, then the issue disappeared:

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 112b4bb009c8..066061fbeeb3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -805,7 +805,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLD_ADDR] = NLA_POLICY_EXACT_LEN(ETH_ALEN),
 	[NL80211_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_MAX_NUM_AKM_SUITES] = { .type = NLA_REJECT },
-	[NL80211_ATTR_PUNCT_BITMAP] = NLA_POLICY_RANGE(NLA_U8, 0, 0xffff),
+	[NL80211_ATTR_PUNCT_BITMAP] = { .type = NLA_U32 },
 };
 
 /* policy for the key attributes */
@@ -3183,9 +3183,15 @@ static int nl80211_parse_punct_bitmap(struct cfg80211_registered_device *rdev,
 				      const struct cfg80211_chan_def *chandef,
 				      u16 *punct_bitmap)
 {
+	u32 bitmap;
+
 	if (!wiphy_ext_feature_isset(&rdev->wiphy, NL80211_EXT_FEATURE_PUNCT))
 		return -EINVAL;
 
+	bitmap = nla_get_u32(info->attrs[NL80211_ATTR_PUNCT_BITMAP]);
+	if (bitmap & 0xFFFF0000)
+		return -EINVAL;
+
 	*punct_bitmap = nla_get_u32(info->attrs[NL80211_ATTR_PUNCT_BITMAP]);
 	if (!cfg80211_valid_disable_subchannel_bitmap(punct_bitmap, chandef))
 		return -EINVAL;

Is there any special reason to move checking the value to 0xffff in
nla_policy?  Otherwise, is this a bug of the warning in
nla_get_range_unsigned()?

Thanks,
Shigeru

