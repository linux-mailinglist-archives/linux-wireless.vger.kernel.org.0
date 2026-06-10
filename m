Return-Path: <linux-wireless+bounces-37630-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZsyIA8RhKWojWAMAu9opvQ
	(envelope-from <linux-wireless+bounces-37630-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 15:08:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E942669972
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 15:08:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KODAAhOb;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37630-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37630-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 121F1322CFAE
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 13:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7C61B86C7;
	Wed, 10 Jun 2026 13:02:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C93B175A73
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 13:02:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096546; cv=none; b=MkJBVyHWbYQ7I6bXCu5Ks5Ro1T8l4MgiATBXSfTNCMSsDyrEIqy1cF8cGkluFVsHKYK+g4p6nE9gNRqN6z8iSvJDZQkZfSh7hWr7P8uqTumPp15lIV0HdnNgkPQFHjLnOzz5z/v5wmfXWsoWFC1mw2wb/d510YZA+94ZZf2Lh34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096546; c=relaxed/simple;
	bh=O2FpipHkAxx8lyGGAugkJtN1FOnLhEuugpiG4Nh3dsc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pKhbfo/6zS1pTBxfBeMJTJRHBlUTx93XvBvWDt7f34v2LCNIfZ+b+xEzb59XfbX+JVZ0rjaM2YrWGpIY4Z74Tmnri6lw1fyGm1bL8TMZlnRZSB9RZIU9L3EWMg7o1wDkZfCKW6Jg96aaBKwS7i04WWlUVeyN6yq9kM67DHPzeiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KODAAhOb; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so4570199f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781096544; x=1781701344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WfddIErJmD4ROUD8rQKLeqr0u5/ajkKTYWno/4Cixrg=;
        b=KODAAhObv3Tdj8jEl0gZKZnEQ/TdAIUWhkOgy0kuGox//6r0AI5HZ1TjiBGdFXBO+A
         5BNsvQb/Rc2mSZfbBSSozTFKbmz+fCTS7GuP6ixbcFmYwR81cucNrDtbD/5jP0x+9cKv
         71EGrPr8WF3azPfe77LDzK8/JLRg3YG3QAtEVXb4Fm4FQCWS6eYttwGiHIeeO4PyvNMR
         LPdENLV2SmoCLX/Y4w7ldliHABZWhLxpTDHGBn98bzAKTvZzgvDVafHjhukGMROpXKa5
         IgsvMq9uyve89vxgqYYSmspQVBtJSOhqSfWje7u/qjYEakachLGhX/GR0M2tgCXbSILu
         WX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096544; x=1781701344;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfddIErJmD4ROUD8rQKLeqr0u5/ajkKTYWno/4Cixrg=;
        b=BOo+BRPKmuvWRWrYnN8NZgfTWXoi5204TpBwpVfEKTPgsoF0HEKqv1IXXZNqzOIJEo
         HiGImn2stPoeNe4Aeziq4yrElxMkq7PSRPbv8/iLzY5qKM1aXWpY61oup2SaFoo6fbAr
         T+Pem/k0gOVOlUroKsbkDwAv51vw25KgXwlWoO3zGp9EJc+4gx7HJkDI9s4Cc/pPq95S
         6/keqt+zh8Njl2I5jq70Njp0b76naPTnfvaxbHRuYk/28ujyH2W1iQakdpm+PAZEP+v1
         H9VmOUUtdWbpEkuBB4tC+4u+A+dZAScnWX6jB9S98UB7B/uGYlul2OMwl/hVsxc6cSgz
         Rn1A==
X-Gm-Message-State: AOJu0YwLJFP0ONrnQOb9VjAFksE9qR4PhcCxQGl861RzNHgetLNaOTCo
	/kron6Xn7oA+UfKhqZF7J2jbRc50b0iOMWrjfp/mZdcDYHQRNlMYAoIfxfJiVQ==
X-Gm-Gg: Acq92OEyyWLyuNlf5yNLYxDGdsb78wI2P4QObYRZOrbJYGGZXE7ddHDv4HFxulhMYLj
	bFATMWwLyBd0eTRs4ok33j67EiBIEXMviM6VLIfUPrDLyNBNCYzkF3G0OOBjipI4Z4zjarmGO/K
	63EtpccuI6w8cbRyzjG8/c9shYUlcJU3pzf5ZZtzNGXFJbYJlzf7p/fHOv3LU8NWqduPYCmDKSQ
	1Ye0/m/NhOaSYxxTeD5WMUQfaL62sHPN6M+bfl0mPlguMOXm1mgFolpSXj6wAqC3eHlh1WUoysu
	y55RDKWIEHpYuLlFv7jgJqN9NMM/RTCj0p9jTcGeqsAyDMSHpQeY16KZX0tKXls+LMYkvFNyc1q
	EpsJWn/rdNwJWo6S+nqT92qSc+2JZ6nhs2A0RHDkSMOYK0zYhekDMkR+N0GNn912JAs0WHs5WZI
	+VdQOhOjlMymwa0dp0cWh7EAmkBxGyI/XhlSC8Rdderjc=
X-Received: by 2002:a05:600c:3e0a:b0:490:5000:917 with SMTP id 5b1f17b1804b1-490c2cb94b8mr322433255e9.1.1781096543536;
        Wed, 10 Jun 2026 06:02:23 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dc4715e4sm44648745e9.0.2026.06.10.06.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 06:02:22 -0700 (PDT)
Message-ID: <9c4beb36-2954-4db0-844a-74ba5eacf21b@gmail.com>
Date: Wed, 10 Jun 2026 16:02:21 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 2/2] wifi: rtw88: 8822b: Don't process RF path C in
 query_phy_status_page1
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ee30b95f-bc68-4711-9b15-cf5fd23c3c48@gmail.com>
Content-Language: en-US
In-Reply-To: <ee30b95f-bc68-4711-9b15-cf5fd23c3c48@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-37630-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E942669972

Replace <= with < in the loop in query_phy_status_page1(). It was
processing data related to RF path C, which this chip doesn't have.
The only bad effect seems to be that the phy_info file in debugfs was
printing unexpected values for RF path C.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index e9e8a7f3f382..37b7a520fea0 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -896,7 +896,7 @@ static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
 	pkt_stat->cfo_tail[RF_PATH_A] = GET_PHY_STAT_P1_CFO_TAIL_A(phy_status);
 	pkt_stat->cfo_tail[RF_PATH_B] = GET_PHY_STAT_P1_CFO_TAIL_B(phy_status);
 
-	for (path = 0; path <= rtwdev->hal.rf_path_num; path++) {
+	for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
 		rssi = rtw_phy_rf_power_2_rssi(&pkt_stat->rx_power[path], 1);
 		dm_info->rssi[path] = rssi;
 		dm_info->rx_snr[path] = pkt_stat->rx_snr[path] >> 1;
-- 
2.54.0


