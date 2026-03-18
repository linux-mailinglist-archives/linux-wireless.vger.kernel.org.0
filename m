Return-Path: <linux-wireless+bounces-33423-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGKPKljxumkBdQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33423-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 19:39:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B926D2C170C
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 19:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B60343036310
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 17:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991163542D8;
	Wed, 18 Mar 2026 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsbMmetx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D04035504D
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855919; cv=none; b=gw/pI5q1OoG1w3/IgSGkpNur1mPgkgTDVdGnbuDLEnrbEqnXXKRYG4iM9ZYk30+z+jZjgpWy5Zk99Zr2S/+EGVurAmr6xflC/Xbc1jGSb9PwKiSJmtwMohh9zpHD4aFPH1w798VfXOljPBZDYKezs7cGk8Gggj+GDSFWOTyG48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855919; c=relaxed/simple;
	bh=efS2lZkv4yg7g9tDwtRURsw63XISZQRYo1qecGyFcNM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Hoq2DfVP4krwbthdk2lBnNUmojjaCOhRdmu92zbqq1D95Q7QDmRPXazUz7Rr5OjAJddqXxF4geffdrc8lFbjWs252A2SQe9Jo8s6uOUgJ2KcmIQ9MZshJjTcAmrwCfxu9Y0wdDsaJTm5ClV/bSgDxk2BGYBmpeJFZU5JOs6Xg5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsbMmetx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so1108575e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773855916; x=1774460716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCAyeQCfTjJMe2lF/fMvn0FK0TqRCqDD+nk9yk6LTnw=;
        b=OsbMmetxg7G1vkT48gB0Y4MdV4iyNitRIFoOf5wbNzrMyYUHyJI0V1q6kZBo3g/FSR
         QSOXWEkezqv7mWUVhzxJuttZr7sWsg666J+/olG2fVq9OeM6PWHtDkoEFR6WGMky9EYr
         8KJozdzd7yND8UnABlBZNtw2JuU1Eb3n7EGSWu8SE0BJUU+UcKSM9pPozdogeln6B03p
         dtPxuoxGfBpi4ABolLhYXxL3Uf4YucbxWDfTOv1wWw95++mCIrRn7bRfSnWbtvTPjmOB
         s7J90XEmzQyFowF0lNmWK5V4JjabyBG+t/DGkaUEsp3Nio1mAn7qm3qrh1RD6P1WdeMG
         HzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773855916; x=1774460716;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eCAyeQCfTjJMe2lF/fMvn0FK0TqRCqDD+nk9yk6LTnw=;
        b=b77T2Qxdq5c5qMZDUaoaNeMC7OKqAIhqn/PXYaxDVZv1RezL+zLWUFVcAmkSqe32wY
         PvhMe6bcPJRh/9HUNnhBOVx0Z+Pj9aE+dUrKn9Zkl57dG3qknHX0OFtewYNX1Cn0VMVW
         9ofvErXkU/fdmSZfb6VI1trSMHe/LrYju07hSy9skZf3sklA9BNpQI6wMHLw3MP+S7p8
         kX/1NMOj3rqkzuE/eEJn6md5lZmf/ZSNCXHjqDQZQqdqUkqWMdBrTd5cONc3Uox1xhXa
         YaMQAWUX8hO1TbZl2WkkooY1yxxRBKiUNiz1h1QJcku+RyVwQ2D71AqOCLObguQQyJue
         1q5g==
X-Gm-Message-State: AOJu0YwrkNEJKZmhNVdJvLMOJu0OsbvZ/i6ATq4e1IahbHDP9PggAI3e
	ySZaAuS6yZ7A57BfiFtWi8hy9wJfN7/u2zxTEzZf+0xKpTZnXp3D3+6j+sKhcw==
X-Gm-Gg: ATEYQzy2yHIU1hjOn2Qcvu43hMLw1Fns5SROvb1BlSyQa9aF88n55NfNaDGq227nA3E
	J8ZXcsxwspG08tlCaYpd6+jgUx0TdIk8WEMT1U6qokimBLegM6xUUYqq3warbWlPoHX6lvxicGq
	WcFeWBbncNwhh6ipk+l0J8m8h/6sFd6kqWp284KQxefpJJhCKrhJnSNkwWDBlAP9/m1We+Kqxph
	Ph1f/W5z7Wb2943OiQZxdkDqY76RvMytf0PNCooSJT2YxTH5b90c/vLYVWIa6kk7UWUt/GQueCE
	p8bwS+zbHa70RpSUSIzyxvPztC4wEuS3WRh7yED70xU0rTm9JmYA3ZokZC2ElX0QZy50kYoGjVS
	3ZL7MWpISxwa+Q4NjV5vhmPIwhm2MeXddPl0vCdX8pKegvwRV+CP0XwpliYkvammzW/TyXT3Abp
	KaeirJqy/SZJNKie/kvGWTXE9Ote/Pdw==
X-Received: by 2002:a05:600c:848d:b0:485:3fd1:9936 with SMTP id 5b1f17b1804b1-486f442e598mr72220485e9.5.1773855916148;
        Wed, 18 Mar 2026 10:45:16 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f462caf0sm37588895e9.2.2026.03.18.10.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 10:45:15 -0700 (PDT)
Message-ID: <2b53fb0d-b1ed-47b6-8caa-2bb9ae2acb80@gmail.com>
Date: Wed, 18 Mar 2026 19:45:13 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next v2] wifi: rtw88: TX QOS Null data the same way as
 Null data
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33423-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B926D2C170C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When filling out the TX descriptor, Null data frames are treated like
management frames, but QOS Null data frames are treated like normal
data frames. Somehow this causes a problem for the firmware.

When connected to a network in the 2.4 GHz band, wpa_supplicant (or
NetworkManager?) triggers a scan every five minutes. During these scans
mac80211 transmits many QOS Null frames in quick succession. Because
these frames are marked with IEEE80211_TX_CTL_REQ_TX_STATUS, rtw88
asks the firmware to report the TX ACK status for each of these frames.
Sometimes the firmware can't process the TX status requests quickly
enough, they add up, it only processes some of them, and then marks
every subsequent TX status report with the wrong number.

The symptom is that after a while the warning "failed to get tx report
from firmware" appears every five minutes.

This problem apparently happens only with the older RTL8723D, RTL8821A,
RTL8812A, and probably RTL8703B chips.

Treat QOS Null data frames the same way as Null data frames. This seems
to avoid the problem.

Tested with RTL8821AU, RTL8723DU, RTL8811CU, and RTL8812BU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Completely different approach: avoid the problem instead of ignoring
   the effects. v1 was here:
   https://lore.kernel.org/linux-wireless/4fc30feb-5616-4e2e-86d8-0d96e4f191c2@gmail.com/
---
 drivers/net/wireless/realtek/rtw88/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index c04ff31d0f1e..e2d288186b30 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -424,7 +424,7 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 		pkt_info->mac_id = rtwvif->mac_id;
 	}
 
-	if (ieee80211_is_mgmt(fc) || ieee80211_is_nullfunc(fc))
+	if (ieee80211_is_mgmt(fc) || ieee80211_is_any_nullfunc(fc))
 		rtw_tx_mgmt_pkt_info_update(rtwdev, pkt_info, sta, skb);
 	else if (ieee80211_is_data(fc))
 		rtw_tx_data_pkt_info_update(rtwdev, pkt_info, sta, skb);
-- 
2.53.0


