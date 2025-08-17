Return-Path: <linux-wireless+bounces-26412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92A7B2927C
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 11:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FBFD4872AB
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Aug 2025 09:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F3522A4E1;
	Sun, 17 Aug 2025 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CF9YY7n7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA2E227EA7
	for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755423683; cv=none; b=bC4SsD2nKJCReQYYyAi8MKf1jkHj9snBzhzaqz6vysIeZy9aivwX0Cuvsnv/ab5icECok3vLmvHxD3LsvtfXRyMbfW5QW8LAOGlIkWAlQFsGAskdKzkx/cFpHY5VmhXIieggNuzR4T31HdET36aMA5ijOQzEHei+3tt2U8nAyL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755423683; c=relaxed/simple;
	bh=IVqOq8VY5ykA1LxUNIZM4bi/9c2LjjftglL+rMie0sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9OkUJ442Ce392rLSDkLcrRYKgYZ/ZB0TPKNnTyBFKehIz7EFASiPds6v32SvPZ7iQ9eZ+BQy1gWGeY4UQMPsQpCPEwNWju/YbbdQsttY2ychWsM5jfDnjJLmcF4rHXOdOBHLiJ4OAD3OjNEwTs7F1hnwwP2/MwubGYMDYeIEuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CF9YY7n7; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70a88dcb665so30997686d6.0
        for <linux-wireless@vger.kernel.org>; Sun, 17 Aug 2025 02:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755423681; x=1756028481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjaSJbfnGpWED1T1ZITbY+rdI/ejDCUJ/o2211bFNEE=;
        b=CF9YY7n7zlbroONBYcEnMJxPIko+QD8hU18z0q9hOPFB3gIJ0esRLn0iGxanMXisqO
         uAwSsbHlERddFRzRnaH0dixuah9obUfqgEpHFdA91KEafupXLZ05qjTELScg2hTOHHAz
         e8ZEqjBh/SOXlGlHqqFFUycqKSjseg0xwS3AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755423681; x=1756028481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjaSJbfnGpWED1T1ZITbY+rdI/ejDCUJ/o2211bFNEE=;
        b=WLEah8VxClT9okYdCuYaQz9e7mNMryegO/XSdB4+S01838acf3MU71CId+cHqjT4JV
         43fIxQZye98iU4FM6XMAHV8b3+b/NgcFdexZ67v0rKdf9f2JKi7fMbYRIDX6pMjn7ly1
         Rw3ZdEgIwlIYCq2r79Fex/iu9hh19ddN8VFqD0irq11iwzDAL6VOt8GxKVEFeTqdk37E
         I18epJ9aTnVBoJwgZzZq2BcZOsmXPoCDYmIpfvrTnipx6sPBpsHw8vi7C2xVMutnzIGn
         zuG+Pm3XfpeLDgJtFb1wvdlJGu0nT3bVlOmCqyQUN3QrOJJElHzjaW8oOqiylVEmf8Fm
         j9tw==
X-Gm-Message-State: AOJu0YyCbDmZtNr39c7bEJam7jChIM/+xEWgsmz6Y3ra98+ChyJnBzPz
	5rZp2jzhN85nkJw43Cje0x0bu/Hgxcn4nOmJQOKjlbSZPrZW8rTAWJ+nb+AL4F2mFXHjeUR2iW/
	73M1+KBNC
X-Gm-Gg: ASbGncuwuvolGg48q/X7aG/hTiFZ0Sf0wfhCTxWacZqAk4/rftj+pLfNHa3ovX3NeCr
	DaHKeB3396wcPezR26ao5Gvt7l8n+rawKC/5+j5W8CFAF5lf2jGzPdt/iz7QxQgKN7ovo+eT4AN
	enW3S2s0JIgwP3FHfxOUKxRtVzias5PEoPJ431SCpoRQaN3b7MYSbHcMp1EheQGItdqDTfzZQVD
	0hsljQhlZi6x9fef2i4calZq4jO0Qb+hvooAdVOTciH2BR7r5vdpRT9jxS+94SqwL+zQ7xDrBTe
	evTGYHo97YUxw3pOp0rorMNkrRnDK+UEIlSHnzNH8WnSmiMlyACbQUTsWCKWhNKd+CXiQHQbEcV
	r4OYnD/eg3N5aTjG4ssB1+w7BEubsLR6tNAL985riZT+nJderROUKyVVytIu2j+4D6j5w8Be5M/
	jyvNzeNQ==
X-Google-Smtp-Source: AGHT+IF0vKN518iR5gUvlTX7eR+3QrdPgnEj+Mwo8hE6UUQTw24S57Zi18GfgCIaVoHjHZuXY8FPbw==
X-Received: by 2002:ad4:5945:0:b0:707:77be:fc76 with SMTP id 6a1803df08f44-70ba7cae369mr114044556d6.51.1755423680960;
        Sun, 17 Aug 2025 02:41:20 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba902f819sm35706346d6.9.2025.08.17.02.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 02:41:20 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Wright Feng <wright.feng@cypress.com>,
	Chi-hsien Lin <chi-hsien.lin@cypress.com>,
	Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH wl-next 4/4] wifi: brcmfmac: support AP isolation to restrict reachability between stations
Date: Sun, 17 Aug 2025 11:41:03 +0200
Message-ID: <20250817094103.941090-5-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250817094103.941090-1-arend.vanspriel@broadcom.com>
References: <20250817094103.941090-1-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wright Feng <wright.feng@cypress.com>

hostapd & wpa_supplicant userspace daemons exposes an AP mode specific
config file parameter "ap_isolate" to the user, which is used to control
low-level bridging of frames between the stations associated in the BSS.

In driver, handle this user setting in the newly defined cfg80211_ops
function brcmf_cfg80211_change_bss() by enabling "ap_isolate" IOVAR in
the firmware.

In AP mode, the "ap_isolate" value from the cfg80211 layer represents,
 0 = allow low-level bridging of frames between associated stations
 1 = restrict low-level bridging of frames to isolate associated stations
-1 = do not change existing setting

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
[arend: indicate ap_isolate support in struct wiphy::bss_param_support]
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 8af402555b5e..4fd25d916ff4 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5958,6 +5958,26 @@ static int brcmf_cfg80211_del_pmk(struct wiphy *wiphy, struct net_device *dev,
 	return brcmf_set_pmk(ifp, NULL, 0);
 }
 
+static int brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *dev,
+				     struct bss_parameters *params)
+{
+	struct brcmf_if *ifp = netdev_priv(dev);
+	int ret = 0;
+
+	/* In AP mode, the "ap_isolate" value represents
+	 *  0 = allow low-level bridging of frames between associated stations
+	 *  1 = restrict low-level bridging of frames to isolate associated stations
+	 * -1 = do not change existing setting
+	 */
+	if (params->ap_isolate >= 0) {
+		ret = brcmf_fil_iovar_int_set(ifp, "ap_isolate", params->ap_isolate);
+		if (ret < 0)
+			brcmf_err("ap_isolate iovar failed: ret=%d\n", ret);
+	}
+
+	return ret;
+}
+
 static struct cfg80211_ops brcmf_cfg80211_ops = {
 	.add_virtual_intf = brcmf_cfg80211_add_iface,
 	.del_virtual_intf = brcmf_cfg80211_del_iface,
@@ -6005,6 +6025,7 @@ static struct cfg80211_ops brcmf_cfg80211_ops = {
 	.update_connect_params = brcmf_cfg80211_update_conn_params,
 	.set_pmk = brcmf_cfg80211_set_pmk,
 	.del_pmk = brcmf_cfg80211_del_pmk,
+	.change_bss = brcmf_cfg80211_change_bss,
 };
 
 struct cfg80211_ops *brcmf_cfg80211_get_ops(struct brcmf_mp_device *settings)
@@ -7659,6 +7680,9 @@ static int brcmf_setup_wiphy(struct wiphy *wiphy, struct brcmf_if *ifp)
 				    BIT(NL80211_BSS_SELECT_ATTR_BAND_PREF) |
 				    BIT(NL80211_BSS_SELECT_ATTR_RSSI_ADJUST);
 
+
+	wiphy->bss_param_support = WIPHY_BSS_PARAM_AP_ISOLATE;
+
 	wiphy->flags |= WIPHY_FLAG_NETNS_OK |
 			WIPHY_FLAG_PS_ON_BY_DEFAULT |
 			WIPHY_FLAG_HAVE_AP_SME |
-- 
2.43.5


