Return-Path: <linux-wireless+bounces-219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B070F7FD71D
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 13:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562DA282F67
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E2C1D540;
	Wed, 29 Nov 2023 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UoNrcirY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3FAD44
	for <linux-wireless@vger.kernel.org>; Wed, 29 Nov 2023 04:50:51 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2ec9a79bdso4405326b6e.3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Nov 2023 04:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701262250; x=1701867050; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QloJutLdUWDtbgtt7v9JSFeYg5x5HY0WpF0Z7br7LNc=;
        b=UoNrcirYsWeZH1w1/3/m6MU+CQaJ9nxnL3L7hLrmrDvpl8MIfTeiU3GSwnq2qevIIr
         aFnrPSgLE6Jp4CE/FTgm+9g9+JQz+G6GC18gMf8BrOs3wTk76krY/OFP8/8w37A/wi/6
         rPx0uMsQDZdNGNAn+C8eZG33RQpaiGLQR/RpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701262250; x=1701867050;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QloJutLdUWDtbgtt7v9JSFeYg5x5HY0WpF0Z7br7LNc=;
        b=KufSkHAuUCmhXb1jHRUceni+q6nsXTszT8FTSuRYq7MbZr3Owkd264LPSzV23ivYXf
         nUnYDbs2mM8KBm2/mVFb80Ufo9BTZwruQqkvpKl61nbDou+rHYiP99yhaR8gL00Qb/Ua
         VQBzWScbg+VowRErhXy6AGGq/rWEwxbfL5lK6/6/Avq8knvwQOHOSOp3aMv+bqC8dCHs
         K77CCy4EDjQH70Uu2FBu9Jiw3hgdjlPN61VgHlpQz0Q3x9JDoWKTswOsQwW7BtouzcTc
         0sxUMxnXrdonK2bgvbaUPK4cgooXlTv/IoDb6B2Lj7OCD247aYlp825H8cWjc3Zg7fnR
         VX2g==
X-Gm-Message-State: AOJu0Yw553t1uQ8UDDsQaq20TbbXR0Rkm5XLVXwnYf13Bx0jelvUqWPK
	4VuMRm209qwcWidpcT9SQPhw+w==
X-Google-Smtp-Source: AGHT+IGlPzk76rVmAwhhVxa0w5c+EBKRP8yyA1bZM10N/7XqMYMZUwX0njfUQ2Y50qaLi3iNoJZPYA==
X-Received: by 2002:a05:6808:3009:b0:3a8:7c67:7f5 with SMTP id ay9-20020a056808300900b003a87c6707f5mr23698333oib.1.1701262250466;
        Wed, 29 Nov 2023 04:50:50 -0800 (PST)
Received: from ibnvda0196.ibn.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id m1-20020a63fd41000000b005891f3af36asm11312812pgj.87.2023.11.29.04.50.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Nov 2023 04:50:49 -0800 (PST)
From: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	jithu.jance@broadcom.com,
	Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Subject: [PATCH v4 1/1] wifi: nl80211: Extend del pmksa support for SAE and OWE security
Date: Wed, 29 Nov 2023 18:20:43 +0530
Message-Id: <ecdae726459e0944c377a6a6f6cb2c34d2e057d0.1701262123.git.vinayak.yadawad@broadcom.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000207a3e060b49fc85"

--000000000000207a3e060b49fc85
Content-Transfer-Encoding: 8bit

Current handling of del pmksa with SSID is limited to FILS
security. In the current change the del pmksa support is extended
to SAE/OWE security offloads as well. For OWE/SAE offloads, the
PMK is generated and cached at driver/FW, so user app needs the
capability to request cache deletion based on SSID for drivers
supporting SAE/OWE offload.

Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
---
v1->v2: Addressed review comments for indentation
v2->v3: Addressed review comments for version update in header
v3->v4: Addressed review comments to split nl80211_setdel_pmksa
function
---
 include/uapi/linux/nl80211.h |  3 +-
 net/wireless/nl80211.c       | 92 +++++++++++++++++++++++++++---------
 2 files changed, 71 insertions(+), 24 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index dced2c49daec..b0000875e34e 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -568,7 +568,8 @@
  * @NL80211_CMD_DEL_PMKSA: Delete a PMKSA cache entry, using %NL80211_ATTR_MAC
  *	(for the BSSID) and %NL80211_ATTR_PMKID or using %NL80211_ATTR_SSID,
  *	%NL80211_ATTR_FILS_CACHE_ID, and %NL80211_ATTR_PMKID in case of FILS
- *	authentication.
+ *	authentication. Additionally in case of SAE offload and OWE offloads
+ *	PMKSA entry can be deleted using %NL80211_ATTR_SSID.
  * @NL80211_CMD_FLUSH_PMKSA: Flush all PMKSA cache entries.
  *
  * @NL80211_CMD_REG_CHANGE: indicates to userspace the regulatory domain
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 569234bc2be6..4e9a008cd338 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12173,16 +12173,20 @@ static int nl80211_wiphy_netns(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-static int nl80211_setdel_pmksa(struct sk_buff *skb, struct genl_info *info)
+static int nl80211_set_pmksa(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	int (*rdev_ops)(struct wiphy *wiphy, struct net_device *dev,
 			struct cfg80211_pmksa *pmksa) = NULL;
 	struct net_device *dev = info->user_ptr[1];
 	struct cfg80211_pmksa pmksa;
+	bool ap_pmksa_caching_support = false;
 
 	memset(&pmksa, 0, sizeof(struct cfg80211_pmksa));
 
+	ap_pmksa_caching_support = wiphy_ext_feature_isset(&rdev->wiphy,
+		NL80211_EXT_FEATURE_AP_PMKSA_CACHING);
+
 	if (!info->attrs[NL80211_ATTR_PMKID])
 		return -EINVAL;
 
@@ -12191,16 +12195,15 @@ static int nl80211_setdel_pmksa(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_MAC]) {
 		pmksa.bssid = nla_data(info->attrs[NL80211_ATTR_MAC]);
 	} else if (info->attrs[NL80211_ATTR_SSID] &&
-		   info->attrs[NL80211_ATTR_FILS_CACHE_ID] &&
-		   (info->genlhdr->cmd == NL80211_CMD_DEL_PMKSA ||
-		    info->attrs[NL80211_ATTR_PMK])) {
+	           info->attrs[NL80211_ATTR_FILS_CACHE_ID] &&
+	           info->attrs[NL80211_ATTR_PMK]) {
 		pmksa.ssid = nla_data(info->attrs[NL80211_ATTR_SSID]);
 		pmksa.ssid_len = nla_len(info->attrs[NL80211_ATTR_SSID]);
-		pmksa.cache_id =
-			nla_data(info->attrs[NL80211_ATTR_FILS_CACHE_ID]);
+		pmksa.cache_id = nla_data(info->attrs[NL80211_ATTR_FILS_CACHE_ID]);
 	} else {
 		return -EINVAL;
 	}
+
 	if (info->attrs[NL80211_ATTR_PMK]) {
 		pmksa.pmk = nla_data(info->attrs[NL80211_ATTR_PMK]);
 		pmksa.pmk_len = nla_len(info->attrs[NL80211_ATTR_PMK]);
@@ -12212,28 +12215,71 @@ static int nl80211_setdel_pmksa(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NL80211_ATTR_PMK_REAUTH_THRESHOLD])
 		pmksa.pmk_reauth_threshold =
-			nla_get_u8(
-				info->attrs[NL80211_ATTR_PMK_REAUTH_THRESHOLD]);
+			nla_get_u8(info->attrs[NL80211_ATTR_PMK_REAUTH_THRESHOLD]);
 
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_STATION &&
 	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_CLIENT &&
-	    !(dev->ieee80211_ptr->iftype == NL80211_IFTYPE_AP &&
-	      wiphy_ext_feature_isset(&rdev->wiphy,
-				      NL80211_EXT_FEATURE_AP_PMKSA_CACHING)))
+	    !((dev->ieee80211_ptr->iftype == NL80211_IFTYPE_AP ||
+	       dev->ieee80211_ptr->iftype == NL80211_IFTYPE_P2P_GO) &&
+	       ap_pmksa_caching_support))
 		return -EOPNOTSUPP;
 
-	switch (info->genlhdr->cmd) {
-	case NL80211_CMD_SET_PMKSA:
-		rdev_ops = rdev->ops->set_pmksa;
-		break;
-	case NL80211_CMD_DEL_PMKSA:
-		rdev_ops = rdev->ops->del_pmksa;
-		break;
-	default:
-		WARN_ON(1);
-		break;
+	rdev_ops = rdev->ops->set_pmksa;
+	if (!rdev_ops)
+		return -EOPNOTSUPP;
+
+	return rdev_ops(&rdev->wiphy, dev, &pmksa);
+}
+
+static int nl80211_del_pmksa(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	int (*rdev_ops)(struct wiphy *wiphy, struct net_device *dev, 
+		struct cfg80211_pmksa *pmksa) = NULL; 
+	struct net_device *dev = info->user_ptr[1];
+	struct cfg80211_pmksa pmksa;
+	bool sae_offload_support = false;
+	bool owe_offload_support = false;
+	bool ap_pmksa_caching_support = false;
+
+	memset(&pmksa, 0, sizeof(struct cfg80211_pmksa));
+
+	sae_offload_support = wiphy_ext_feature_isset(&rdev->wiphy,
+		NL80211_EXT_FEATURE_SAE_OFFLOAD);
+	owe_offload_support = wiphy_ext_feature_isset(&rdev->wiphy,
+		NL80211_EXT_FEATURE_OWE_OFFLOAD);
+	ap_pmksa_caching_support = wiphy_ext_feature_isset(&rdev->wiphy,
+		NL80211_EXT_FEATURE_AP_PMKSA_CACHING);
+
+	if (info->attrs[NL80211_ATTR_PMKID])
+		pmksa.pmkid = nla_data(info->attrs[NL80211_ATTR_PMKID]);
+
+	if (info->attrs[NL80211_ATTR_MAC]) {
+		pmksa.bssid = nla_data(info->attrs[NL80211_ATTR_MAC]);
+	} else if (info->attrs[NL80211_ATTR_SSID]) {
+		/* SSID based pmksa flush suppported only for FILS,
+		 * OWE/SAE OFFLOAD cases
+		 */
+		if (info->attrs[NL80211_ATTR_FILS_CACHE_ID] &&
+		    info->attrs[NL80211_ATTR_PMK]) {
+			pmksa.cache_id = nla_data(info->attrs[NL80211_ATTR_FILS_CACHE_ID]);
+		} else if (!sae_offload_support && !owe_offload_support) {
+			return -EINVAL;
+		}
+		pmksa.ssid = nla_data(info->attrs[NL80211_ATTR_SSID]);
+		pmksa.ssid_len = nla_len(info->attrs[NL80211_ATTR_SSID]);
+	} else {
+		return -EINVAL;
 	}
 
+	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_STATION &&
+	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_CLIENT &&
+	    !((dev->ieee80211_ptr->iftype == NL80211_IFTYPE_AP ||
+	       dev->ieee80211_ptr->iftype == NL80211_IFTYPE_P2P_GO) &&
+	       ap_pmksa_caching_support))
+		return -EOPNOTSUPP;
+
+	rdev_ops = rdev->ops->del_pmksa;
 	if (!rdev_ops)
 		return -EOPNOTSUPP;
 
@@ -16911,7 +16957,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 	{
 		.cmd = NL80211_CMD_SET_PMKSA,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = nl80211_setdel_pmksa,
+		.doit = nl80211_set_pmksa,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
 					 NL80211_FLAG_CLEAR_SKB),
@@ -16919,7 +16965,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 	{
 		.cmd = NL80211_CMD_DEL_PMKSA,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
-		.doit = nl80211_setdel_pmksa,
+		.doit = nl80211_del_pmksa,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
-- 
2.32.0


--000000000000207a3e060b49fc85
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
RY30ttFfLGgUxOvRzd7UPGXmjiRyV20Vv+kGag5aTueKGHUv49TWypHgJc4PX8L9y3VouEhbWmGb
bwuQjKELfovabHM5PWUVRda3t72kGFVMkIZ65u6DCdyjPFCUGnMCAwEAAaOCAd0wggHZMA4GA1Ud
DwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggr
BgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3
Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4
aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmww
JwYDVR0RBCAwHoEcdmluYXlhay55YWRhd2FkQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUS9fHYxc9qAJz
gfBKun+P2LFASWAwDQYJKoZIhvcNAQELBQADggEBABiMQNJRdQCxXwqwqb49w0ZXCxsSrs3gS4NA
G3H9oJuvzJ8ml5Z9l9p9PGPHcrmc/BdFjIIu/wQftGETAf1+W6AvxXqYmA2flaogebRueqCMQJiy
xbJlOSry64AGOzHYULvI70tt9woEYgSx3I703b7c8o7eWCiU267y/WNzH+MpZ12h9q0Jwhw8uH9S
BTl38q8FNdCLAiM1OD+blhu7LqMLVaAEEeoUGhRxdNkvMGss1Z7/ZefenAfm9IpiaGR0PQhBwI7c
spqD/wIJUULcXiaj0eatDUjsrx3QN9OZOh3iubCt0uBoxCQUGuvxqd3Qz4FVKMSzEIzs8v/hwR+T
nTkxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxIxd7r
XtHLz48aMtQwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGsss6GmEOk2IoqU6d4d
KzO6/BIpG4tdwyGWN5AAmdwlMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTIzMTEyOTEyNTA1MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBQR72VHYzfp+A/euR7U5+cLCOhaDtT87O/bfmX
OdSrJtfdTt2DXyZFgcZRnZsSgO4SMI419j+qs+RQTTM3wAxySNlf/0z0SgaT0KvQDpQuMJcbHPEC
YLPtSOkdpfwwLGQPAat/tdEIOqbxTGpSCKXN3yzBT7iYNs4o1GKly7NAxhsthqSKAqylDVYn5epD
ACuLSebOod/+2BalIHp6pz2P520vFG/HtK/joZNIOo7KBSl5c4s7a/vWywi7tBqkxAZtqnSVbJWp
NcsMH++KWRFmwkyQdI/k9yKmhbT1QS3SH6xkZiOi7YTsUsmrGl66qUNlFtoNm6fGxd1kcJzdiROp
--000000000000207a3e060b49fc85--

