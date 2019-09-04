Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66BF5A8D26
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 21:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfIDQ1s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 12:27:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45901 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731466AbfIDQ1s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 12:27:48 -0400
Received: by mail-ot1-f65.google.com with SMTP id g16so9356872otp.12
        for <linux-wireless@vger.kernel.org>; Wed, 04 Sep 2019 09:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WQeCDPKQBu2fWuHVTnoab9eUK7IeZULnpZ8wFyyA8DY=;
        b=lGZ/EggBcP7o3MZpyN21TQaf07ZYCxl2bRFLp1BiQ/4pQBSCd9yNRGMSDYUvdInFGP
         CklH1T8BAVhEDF+J6KDBtkyBAp/0qn+ECaNTjPUTEzniR0cySwZNOifMw4gDRD72Z47/
         4aAtmKoZX8r5gxEMs3eILrvQGbuAgAOzN2yqIpc7ro49dXJ/Frg3d94lDYYVFKxHw8T+
         pcbLWS/3UU9Eten5dY7a+OpJRcNJWJOpFoFvz2F7/ocXCgxuYegnNCPSx+IE1E+4B5Av
         sBIbOHQKACeBrxHULvNfi0f/+tRiWX6OnbtDI67aWVDCb92qZFOhPviXX/MGsxMq8y/M
         00pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WQeCDPKQBu2fWuHVTnoab9eUK7IeZULnpZ8wFyyA8DY=;
        b=j298A1HJWj29xjjF3CjQtrI7lI37Iw4d5wFv6kMLugtR6H6i3IESmjYhlOZ8UgUWpC
         fUoHUMrPbnP0hb4y7RfOSE4iFn7C4S3e4WVoESufkhVcbDaEaLgcXruYjl+8JFnxXsSD
         Tm3DyscYdOOcskzEUMLyhHtdAryaTmRzJbLD0cxLKxK35AOeM3+vRf3H5p71PCONnMQV
         Uj9XjdrYESEC6iiU7JynbiEG2S2t4zaAZJbdfHJizqGkSgt2tCUUdWErnN2I9HeHK3RD
         neBLKyynxGzjD895XCtCxH96ZTIfSDZb5KCuFEGVlJ4WgDOavRW4gIo3Kz0oNe1TFw42
         Wx7w==
X-Gm-Message-State: APjAAAXl70hFLmjDUMuIYCw0JZgsyvVrE/70e7zCWFRxYQSQQ8PHMawH
        Gr0+ely2vX53ACWO5OmkYvX1clIO
X-Google-Smtp-Source: APXvYqxV8hQDWdtH2+q9IKESDuuM7e0nUEGkk4CeXHSo0Oj9xRoqlXjB8Ux/FWqiwR5j/8+pv4voeg==
X-Received: by 2002:a05:6830:204e:: with SMTP id f14mr11697088otp.298.1567614466516;
        Wed, 04 Sep 2019 09:27:46 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id u17sm5737513oif.11.2019.09.04.09.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 09:27:46 -0700 (PDT)
From:   Denis Kenzior <denkenz@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] nl80211: Support mgmt frame unregistrations
Date:   Wed,  4 Sep 2019 11:22:39 -0500
Message-Id: <20190904162239.2075-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently nl80211 supports purging management frame registrations
only under the following circumstances:
	- If the underlying wireless device is destroyed
	- If userspace closes the socket associated with that frame
	registration

Thus userspace applications that want to gracefully support changing
interface modes (and thus the set of management frames they're
interested in seeing) must resort to opening multiple genl sockets and
manage these sockets appropriately.  To state another way, it is
currently not possible to write a userspace application that utilizes a
single nl80211 genl socket, instead it must open multiple genl sockets
for multiple wdevs on multiple phys.

This commit introduces two new NL80211 commands:
NL80211_CMD_REGISTER_FRAME2 and NL80211_CMD_UNREGISTER_FRAME.  The
former acts very much like NL80211_CMD_REGISTER_FRAME, except it returns
an NL80211_ATTR_COOKIE with a unique id identifying the management frame
registration.  This cookie can then be used with
NL80211_CMD_UNREGISTER_FRAME to delete a previous registration.

NL80211_CMD_UNREGISTER_FRAME can also be used to remove all frame
registrations currently associated with the calling socket.  This is
done by omitting the NL80211_ATTR_COOKIE attribute.  Only frame
registrations owned by the calling socket can be removed.

NL80211_CMD_REGISTER_FRAME2 was added to keep backwards compatibility
with older clients which rely on NL80211_CMD_REGISTER_FRAME and might
not be able to deal with introduction of a new attribute as a part of
the return value.

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 include/uapi/linux/nl80211.h | 17 ++++++++
 net/wireless/core.h          |  4 +-
 net/wireless/mlme.c          | 37 +++++++++++++++-
 net/wireless/nl80211.c       | 83 +++++++++++++++++++++++++++++++++++-
 4 files changed, 137 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index beee59c831a7..cef7e6920a6d 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1101,6 +1101,20 @@
  *	peer MAC address and %NL80211_ATTR_FRAME is used to specify the frame
  *	content. The frame is ethernet data.
  *
+ * @NL80211_CMD_REGISTER_FRAME2: Same as %NL80211_CMD_REGISTER_FRAME,
+ *	except returns an ATTR_COOKIE so that the frame can be unregistered
+ *	Unlike %NL80211_CMD_REGISTER_FRAME, this command requires a frame
+ *	type attribute.  Registration can be dropped
+ *	using %NL80211_CMD_UNREGISTER_FRAME
+ *
+ * @NL80211_CMD_UNREGISTER_FRAME: Unregisters a previously registered frame
+ *	that was registered with %NL80211_CMD_REGISTER_FRAME2.  If
+ *	%NL80211_ATTR_COOKIE is provided, then a single frame registration
+ *	matching that cookie is unregistered.  Otherwise, all frames
+ *	associated with the current socket are unregistered.  Note that this
+ *	command can only affect registrations for a single wdev.  So
+ *	%NL80211_ATTR_IFINDEX or %NL80211_ATTR_WDEV must be provided.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1325,6 +1339,9 @@ enum nl80211_commands {
 
 	NL80211_CMD_PROBE_MESH_LINK,
 
+	NL80211_CMD_REGISTER_FRAME2,
+	NL80211_CMD_UNREGISTER_FRAME,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 77556c58d9ac..c81a03fa8d39 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -385,9 +385,11 @@ void cfg80211_mlme_down(struct cfg80211_registered_device *rdev,
 			struct net_device *dev);
 int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_pid,
 				u16 frame_type, const u8 *match_data,
-				int match_len);
+				int match_len, u64 cookie);
 void cfg80211_mlme_unreg_wk(struct work_struct *wk);
 void cfg80211_mlme_unregister_socket(struct wireless_dev *wdev, u32 nlpid);
+bool cfg80211_mlme_remove_registrations(struct wireless_dev *wdev,
+					u32 nlportid, u64 cookie);
 void cfg80211_mlme_purge_registrations(struct wireless_dev *wdev);
 int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 			  struct wireless_dev *wdev,
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index f9462010575f..3cf189742dfb 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -425,6 +425,8 @@ struct cfg80211_mgmt_registration {
 
 	__le16 frame_type;
 
+	u64 cookie;
+
 	u8 match[];
 };
 
@@ -470,7 +472,7 @@ void cfg80211_mlme_unreg_wk(struct work_struct *wk)
 
 int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 				u16 frame_type, const u8 *match_data,
-				int match_len)
+				int match_len, u64 cookie)
 {
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
@@ -519,6 +521,7 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 	nreg->nlportid = snd_portid;
 	nreg->frame_type = cpu_to_le16(frame_type);
 	nreg->wdev = wdev;
+	nreg->cookie = cookie;
 	list_add(&nreg->list, &wdev->mgmt_registrations);
 	spin_unlock_bh(&wdev->mgmt_registrations_lock);
 
@@ -567,6 +570,38 @@ void cfg80211_mlme_unregister_socket(struct wireless_dev *wdev, u32 nlportid)
 		wdev->ap_unexpected_nlportid = 0;
 }
 
+bool cfg80211_mlme_remove_registrations(struct wireless_dev *wdev,
+					u32 nlportid, u64 cookie)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+	struct cfg80211_mgmt_registration *reg, *tmp;
+	bool removed = false;
+
+	spin_lock_bh(&wdev->mgmt_registrations_lock);
+
+	list_for_each_entry_safe(reg, tmp, &wdev->mgmt_registrations, list) {
+		/* always match nlportid so that clients cannot mess with
+		 * entries of other clients
+		 */
+		if (reg->nlportid != nlportid)
+			continue;
+
+		if (cookie && reg->cookie != cookie)
+			continue;
+
+		list_del(&reg->list);
+		removed = true;
+		spin_lock(&rdev->mlme_unreg_lock);
+		list_add_tail(&reg->list, &rdev->mlme_unreg);
+		spin_unlock(&rdev->mlme_unreg_lock);
+	}
+
+	spin_unlock_bh(&wdev->mgmt_registrations_lock);
+	cfg80211_process_mlme_unregistrations(rdev);
+
+	return removed;
+}
+
 void cfg80211_mlme_purge_registrations(struct wireless_dev *wdev)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3e30e18d1d89..749ededbff19 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10464,10 +10464,18 @@ static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct wireless_dev *wdev = info->user_ptr[1];
 	u16 frame_type = IEEE80211_FTYPE_MGMT | IEEE80211_STYPE_ACTION;
+	int err;
+	u64 cookie = 0;
+	struct sk_buff *msg = NULL;
+	void *hdr = NULL;
 
 	if (!info->attrs[NL80211_ATTR_FRAME_MATCH])
 		return -EINVAL;
 
+	if (info->genlhdr->cmd == NL80211_CMD_REGISTER_FRAME2 &&
+	    !info->attrs[NL80211_ATTR_FRAME_TYPE])
+		return -EINVAL;
+
 	if (info->attrs[NL80211_ATTR_FRAME_TYPE])
 		frame_type = nla_get_u16(info->attrs[NL80211_ATTR_FRAME_TYPE]);
 
@@ -10490,9 +10498,64 @@ static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->mgmt_tx)
 		return -EOPNOTSUPP;
 
-	return cfg80211_mlme_register_mgmt(wdev, info->snd_portid, frame_type,
+	if (info->genlhdr->cmd == NL80211_CMD_REGISTER_FRAME2) {
+		msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+		if (!msg)
+			return -ENOMEM;
+
+		hdr = nl80211hdr_put(msg, info->snd_portid, info->snd_seq, 0,
+				     NL80211_CMD_REGISTER_FRAME2);
+		if (!hdr) {
+			err = -ENOBUFS;
+			goto free_msg;
+		}
+
+		cookie = cfg80211_assign_cookie(rdev);
+	}
+
+	err = cfg80211_mlme_register_mgmt(wdev, info->snd_portid, frame_type,
 			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
-			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
+			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]),
+			cookie);
+
+	if (info->genlhdr->cmd == NL80211_CMD_REGISTER_FRAME2) {
+		if (err)
+			goto free_msg;
+
+		if (nla_put_u64_64bit(msg, NL80211_ATTR_COOKIE, cookie,
+				      NL80211_ATTR_PAD))
+			goto nla_put_failure;
+
+		genlmsg_end(msg, hdr);
+
+		return genlmsg_reply(msg, info);
+	}
+
+	return err;
+
+ nla_put_failure:
+	err = -ENOBUFS;
+ free_msg:
+	nlmsg_free(msg);
+	return err;
+}
+
+static int nl80211_unregister_mgmt(struct sk_buff *skb, struct genl_info *info)
+{
+	struct wireless_dev *wdev = info->user_ptr[1];
+	u64 cookie = 0;
+
+	if (info->attrs[NL80211_ATTR_COOKIE]) {
+		cookie = nla_get_u64(info->attrs[NL80211_ATTR_COOKIE]);
+		if (!cookie)
+			return -EINVAL;
+	}
+
+	if (!cfg80211_mlme_remove_registrations(wdev, info->snd_portid,
+						cookie))
+		return -ENOENT;
+
+	return 0;
 }
 
 static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
@@ -14283,6 +14346,22 @@ static const struct genl_ops nl80211_ops[] = {
 		.internal_flags = NL80211_FLAG_NEED_WDEV |
 				  NL80211_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL80211_CMD_REGISTER_FRAME2,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = nl80211_register_mgmt,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = NL80211_FLAG_NEED_WDEV |
+				  NL80211_FLAG_NEED_RTNL,
+	},
+	{
+		.cmd = NL80211_CMD_UNREGISTER_FRAME,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = nl80211_unregister_mgmt,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = NL80211_FLAG_NEED_WDEV |
+				  NL80211_FLAG_NEED_RTNL,
+	},
 	{
 		.cmd = NL80211_CMD_FRAME,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-- 
2.19.2

