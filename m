Return-Path: <linux-wireless+bounces-31116-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ByoFfuIc2krxAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31116-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 15:43:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F088B77350
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 15:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B72DC302447A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED8630EF93;
	Fri, 23 Jan 2026 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJk358SU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9173033F0
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179351; cv=none; b=AsppeU7xUnqlLGrlDD+VH4lWiOjDI1A8lIhERex0OlIWA4g3StMf/r/PkA156F9HLUWI3TRKDuOcREWx3gNBtM2/ILQfn1ROcjqwkyXv8sYdFyMkwyCvs3fESODlrRJH8Vvbu/61s2yLgTuNB9tCYuyDXM87xcrX9GPRkr8sawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179351; c=relaxed/simple;
	bh=p43aLabD/puDjWQUqaGE0D8ughCizWfyPzXmSUcJbHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUYBCVcHJcX80ZzVVaNSpUxeO6Qt2VfUevsKDsIp2/W/KFopWRBrvL2DKRLrFLcTNbBKrNsvYj+S8BwI7trbL9zNC8K3Gw52VRb3+dcmOjX30yhKUAjsGjDubW8X+EFbgT11CSzH4MSE4jqKoneurIJhaZtm32zIWd059K9BG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJk358SU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432d2c96215so1989777f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 06:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769179348; x=1769784148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jWPSO8yrPKFAwMl+wUmEuXeK3SQbOWFRTBlMKq9vDWM=;
        b=UJk358SU/04cKXpyVPN5cF8cbJ7iOAEMWvXuMXpeE5nO+JJE54yiRi+PcoYgba3JD6
         A9KR8hWiRVajdQnOPIVCdimzyDZjjCr56L0m2nOj0ortoZT6lKyDU4+P9OrRYXX+p8tY
         O4iAsyA1+qrtKFZ1eUhwmJEyCTwDVpUtPSSyRVw6QVj/4jUvu8nhP6Gh0CmNYKTb5sE7
         YXG/Da50/4aW+yxQ09OgWzh5MU5MGjGjIHvDfdYW5UP+9EhLHP0dArrhIa0bRwfxYIbR
         NNRAv94YfC/Wkke/AqXnMbrwiRCe4ABkyTDSsPSA/0IKxirTWa/HBworKmtuIMKZ21Ju
         gz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769179348; x=1769784148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWPSO8yrPKFAwMl+wUmEuXeK3SQbOWFRTBlMKq9vDWM=;
        b=ncb62d5VzE0YSX+UFAYxumzEKVILk+zvORXqfDSRT8286vuV8iO4UNJ3XSbwlzMUXH
         YH6QZXH5re8NRyW4QVU+/iWGffk0EwredZzeWt+No8zu6gTe0vVzC4so7p+SYJ4KVwe0
         9un9Vy6TGscAh+w//p2lPXNXj65/pPf78bRvtpzX3pXECiiY/3P6qks8p3vDmdQ2SZ60
         4zf3JAcVf4Y9jTf4mgA+98XvezVB52hUjShqO2M3Fh9n8tV6hKOFn90jISX7dxj7moGW
         i/ycpvfrJSpP9DhyTqmqpy0kYtliMln1d9ITieqxfQjq5j9ao3w1QD9G5Qja8YGskSc2
         Hewg==
X-Gm-Message-State: AOJu0Ywm3ttUhB5amBvK3j2t4C2/zN1KZGEzzj6VDO2SjtOWVdxyQGWM
	7an6Mx78lof5NWAqFB7l+AVCksPWa4ZdYROvGF2aaMQDscOMSKOAaXa6lWks0g==
X-Gm-Gg: AZuq6aI64BqhV803WqGvap9vQnfuan/eZuHfk6+7GVops24oPZhPQE0YatOKuFWxSdO
	2ogqFXzrQbf39kq1bSg4RVHtfeqr4tPq+Z5zY7k3XyiWqx1RnlaXcqvZcEGzZq/HuCY0dvQsX5Y
	tY5Ub6GNymIVhWTFpXbuc3/3+ocwmWUMkwFzHOjTJT+ug/F31PR+e0pkhPGozRAKxgvS4fS+iZx
	jUud26f8SiEH87HO8u9dhIn/Ckvk7e+6qsgzEpFXkq7ERkkcUQIe7P0Bylm+D8uFkUasOjGKgmc
	TdLPQxnVlpjBWvNYCUgLC5Ayf9uEBxZOdKGpKjKyuvhc7/joT1yNOfPZdfkBmhHRkReB6kDJaGy
	o/YntPXDtv7gyPh3CnecDuJ7zm5xIbUU9kxR7RI+sDyNDmy1i8jN/0cW69uVFO/CrnCickrO/Oq
	XlYBzbkzw4/j4yDytfPZVUtomKgtUZx5YU/a97/YAzDYYZc4EXGTmi0/8=
X-Received: by 2002:a05:6000:607:b0:42f:b3b9:874d with SMTP id ffacd0b85a97d-435b15fa1e6mr5912288f8f.37.1769179345634;
        Fri, 23 Jan 2026 06:42:25 -0800 (PST)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f73855sm7125106f8f.29.2026.01.23.06.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 06:42:25 -0800 (PST)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next] wifi: ath12k: avoid setting 320MHZ support on non 6GHz band
Date: Fri, 23 Jan 2026 15:42:24 +0100
Message-ID: <20260123144224.2216923-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-31116-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F088B77350
X-Rspamd-Action: no action

On a split phy qcn9274 (2.4GHz + 5GHz low), "iw phy" reports 320MHz
realated features on the 5GHz band while it should not:

    Wiphy phy1
    [...]
        Band 2:
    [...]
            EHT Iftypes: managed
    [...]
                EHT PHY Capabilities: (0xe2ffdbe018778000):
                    320MHz in 6GHz Supported
    [...]
                    Beamformee SS (320MHz): 7
    [...]
                    Number Of Sounding Dimensions (320MHz): 3
    [...]
                EHT MCS/NSS: (0x22222222222222222200000000):

This is also reflected in the beacons sent by a mesh interface started on
that band. They erroneously advertise 320MHZ support too.

This should not happen as the spec at section 9.4.2.323.3 says we should
not set the 320MHz related fields when not operating on a 6GHz band.
For example it says about Bit 0 "Support For 320 MHz In 6 GHz"

  "Reserved if the EHT Capabilities element is indicating capabilities for
   the 2.4 GHz or 5 GHz bands."

Fix this by clearing the related bits when converting from WMI eht phy
capabilities to mac80211 phy capabilities, for bands other than 6GHz.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 84c29e4896a4..14947fdb9813 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4888,6 +4888,7 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
 				       __le32 cap_info_internal)
 {
 	struct ath12k_band_cap *cap_band = &pdev->cap.band[band];
+	u8 *phy_cap = (u8 *)&cap_band->eht_cap_phy_info[0];
 	u32 support_320mhz;
 	u8 i;
 
@@ -4901,8 +4902,14 @@ static void ath12k_wmi_eht_caps_parse(struct ath12k_pdev *pdev, u32 band,
 	for (i = 0; i < WMI_MAX_EHTCAP_PHY_SIZE; i++)
 		cap_band->eht_cap_phy_info[i] = le32_to_cpu(cap_phy_info[i]);
 
-	if (band == NL80211_BAND_6GHZ)
+	if (band == NL80211_BAND_6GHZ) {
 		cap_band->eht_cap_phy_info[0] |= support_320mhz;
+	} else {
+		phy_cap[0] &= ~IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+		phy_cap[1] &= ~IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK;
+		phy_cap[2] &= ~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MASK;
+		phy_cap[6] &= ~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_320MHZ;
+	}
 
 	cap_band->eht_mcs_20_only = le32_to_cpu(supp_mcs[0]);
 	cap_band->eht_mcs_80 = le32_to_cpu(supp_mcs[1]);
-- 
2.52.0


