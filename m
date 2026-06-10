Return-Path: <linux-wireless+bounces-37629-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u4p9NThhKWoNWAMAu9opvQ
	(envelope-from <linux-wireless+bounces-37629-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 15:06:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F1D669933
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 15:06:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=K9uCGLU4;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37629-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37629-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C1C1304F2C1
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 13:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F027376025;
	Wed, 10 Jun 2026 13:01:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D51A3164
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 13:01:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096500; cv=none; b=P1iMmDpiaWgrl32y5KGC49e3hit6woyljNqe9vBCO8AT8YetEjl0KdpYFRPSuoS1Iiwv+XyWHWDSpqIDBATaKdJvcb1BNAblUCPd+XQnAdJA/f1Q4AuafkSc3YllzD7+sN/tOcxX4Y35/pqiGbk5mw6NKvABSVV+ecNiV0CgAOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096500; c=relaxed/simple;
	bh=TPF+Kc4sukfTSxTestLChVAYSt+WK31qOmvvIhggxrs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nnZ/PtjoRrCh+mJl4eh9dFW9sJ8QcIzYrpuO6jpDowzsg4hKOnJW7Z53C5MKz/W0AIhwg754aLvTKZbD4YgMiLUWQP5I1bx9HxHwdrXx6HTJ/e1ukLkAKA4egr2lFZVjmTjPZKkHUDdbiGUGxT+98O1rsVLhYbm0yjNEKdb7SRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9uCGLU4; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b915ded5so58771445e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781096498; x=1781701298; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKd8md0UJBm1riKJyZwHeoaJBroRqb5AUnwURp9MeyQ=;
        b=K9uCGLU4qEHh097dpEwNdC02xJg+U3SaaXVJeHlVI4XpgSnZptsB3VS+O7KUIbT7LG
         3nahdUCT2075xKxASmG10kGQUznLmYUTKnGVSW7Lawq0jN3wKAoawyplOxoIuP7jos5i
         qOqJtWjVITMbnVUAepWnC24fGN451Ap2BtSh/Aasf2Crik35AK0LaaYDZgyu/JBnX3D0
         VXATTyl7ZIHHnWI2KyXXcFvHnTH5DjQnSAl/sRBmdAPTxLmHnyXlcFXH0xd/0Ck3FntK
         AO3QlKppBpN/Z2mPS6cxnALjmDmZdSycU3ugBj5/ZeW/r59AIRLw0ZKwqFLvSUuh0uJi
         91iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096498; x=1781701298;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKd8md0UJBm1riKJyZwHeoaJBroRqb5AUnwURp9MeyQ=;
        b=q4HzDipfVqsjKdCHb+ZL+NgN3DCkjvDodd0tJfm/z1NsAiB4FIec1NdDS6Zmy1yFJy
         ZhO1QrTigqnYKJXxL/2LMOKgN49o8xJqjGl6fD7yJI4qauAN6iSnnvoyD+RNRBHE0iPT
         hULINudninGIJuXvmUxtJKsREfaJ+DAJ5I7W8TxpoO6KYMjds4VTHLWvRx9Nw54ywfBI
         N7oS9uuAqonF8mEO2Q/sFSSuUnI8+ys4Kktq9o3N4FC+KlBrvpfWzOd0tElkDHBWnrrW
         1kdQP7eYdzQxQNWr0+/UNArHRr64DTdX2zXj7THF9cfps2U5PpreISHibvmTuU1ZHQIv
         zr0w==
X-Gm-Message-State: AOJu0YySh/E/AuUxyrMTZkLErOT3VLULkinWPxxy6gFIGp63xQa3nM1X
	nfRzELaCtJD4MbtntMC9q8qLiGTGR8TmR02SoAwQ5yi9qs3jn4t9aDRpyWqp3A==
X-Gm-Gg: Acq92OE/bBsH1WoL2IqyQvkZevkSrSV7CW+pOXYazOA95wv2gU3K183NIkgtXQQfV1z
	YRct91Z1u92IOpCRAnjqfPDDn5jNjpiW8B0ygyT9IlulQtUmW2H+kT05U6qDex9V37Hn9KPX8NS
	qvKawgYrW7uItDbDcvnDVGOSTOjjhmuv/oqmTjqpGEpCu3NvaXfWoLi8b00Yb1yBJkgZkHaudt+
	fHGaBHlYjDHxmaZzae2tUVPBKznTLB2RzE1Unfl1FbDpmY1Az0uFgtUwetHv2U/RhFCwFGvpK+n
	ArG7reQciLTsMcMJdfNVoKksZ2VYcJCeE80f8Am279XK5pIhIqPBXjGrf28FK6IwlFz379aKkKz
	s+PKWm0J0mUQo0nWsxI2vNvZUVjt04zB93Hy6PdbYl8bjcltcGtIvpCwUscaqExYFboI12f7aI1
	81FzlzcxzxhQA5ab+3xDPcZSsK4uVJ0oyaMzZYKuSOTEA=
X-Received: by 2002:a05:600c:6389:b0:490:33b3:4be0 with SMTP id 5b1f17b1804b1-490c26233abmr414071325e9.20.1781096497642;
        Wed, 10 Jun 2026 06:01:37 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm69751691f8f.12.2026.06.10.06.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 06:01:36 -0700 (PDT)
Message-ID: <ee30b95f-bc68-4711-9b15-cf5fd23c3c48@gmail.com>
Date: Wed, 10 Jun 2026 16:01:35 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next 1/2] wifi: rtw88: 8822c: Don't process RF path C in
 query_phy_status_page{0,1}
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:pkshih@realtek.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37629-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75F1D669933

Replace <= with < in the loops in query_phy_status_page{0,1}(). They
were processing data related to RF path C, which this chip doesn't have.
The only bad effect seems to be that the phy_info file in debugfs was
printing unexpected values for RF path C.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 244c8026479c..80c9f0c11e5c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2584,7 +2584,7 @@ static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
 	pkt_stat->rx_power[RF_PATH_A] = rx_power[RF_PATH_A];
 	pkt_stat->rx_power[RF_PATH_B] = rx_power[RF_PATH_B];
 
-	for (path = 0; path <= rtwdev->hal.rf_path_num; path++) {
+	for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
 		rssi = rtw_phy_rf_power_2_rssi(&pkt_stat->rx_power[path], 1);
 		dm_info->rssi[path] = rssi;
 	}
@@ -2644,7 +2644,7 @@ static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
 	pkt_stat->cfo_tail[RF_PATH_A] = GET_PHY_STAT_P1_CFO_TAIL_A(phy_status);
 	pkt_stat->cfo_tail[RF_PATH_B] = GET_PHY_STAT_P1_CFO_TAIL_B(phy_status);
 
-	for (path = 0; path <= rtwdev->hal.rf_path_num; path++) {
+	for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
 		rssi = rtw_phy_rf_power_2_rssi(&pkt_stat->rx_power[path], 1);
 		dm_info->rssi[path] = rssi;
 		if (path == RF_PATH_A) {
-- 
2.54.0


