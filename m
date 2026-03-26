Return-Path: <linux-wireless+bounces-33993-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNVAAGZnxWkn+AQAu9opvQ
	(envelope-from <linux-wireless+bounces-33993-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:05:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A29BD338E26
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 18:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B6C5302A9E8
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FD44218A9;
	Thu, 26 Mar 2026 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoRz05Fd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AC2406281
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544720; cv=none; b=LMfX8kf6um5cZkD90XiK66naUqmOHeSl+6+FV/nWBOhCxCKBUWzWlyQG4jDbL7F3DCvT4aemPIntr+WOzcoksrU6fpQAzxUZ4XwLcbITYuz/ODgx9KWchSWihTc+BLSRTWtWJ6sP7rJhde0Cts9MVuQsNDUMggspADn6Ojzrd9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544720; c=relaxed/simple;
	bh=tdvVzj7tPQR7JZKOEONlYybYv6vxKU5My0qa0xqD+as=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SYgiJ45zDagt4smqhhTOAcI+8W7ma18P1uiNr2Q08mZTUelTxQA3GLD6xTBY5d2qgoEu7iIauTMMt872Vre9HFbO3PYGiT4Qyy8odCy/pf+hpDWj/Izka3XEQ1vZiY9skUOhj2c/G8L28pzK9hSjMPag0qc2x+vQFFx77x7mrrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoRz05Fd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so12663715e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774544717; x=1775149517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7oOBWb7UN+VoG7zLhsMRNH2vdj01IvN0GLyIluMdcf8=;
        b=IoRz05FdVUYZDHAfLI7Y0O7fOH2wBCoUjSXlM0g8++Bk9GW43u+UodACScUf4FlFU9
         tAiT0hBuJyjh1E8AU7g4MJ8WzkPoMTfIP4MLlN9ijSYj3esk8MEBnIRwKXIBvmwSV+Qp
         fwp059AtDZQaIr5ojQdKJo8yWjQsWJjOgOWm38FHp9px/FJsSEl+jiyVJssogBf2ZYca
         8jnUEaGP7h5eksX0/iSGoqfW7XIfnziOGA9LoDPYQwv1HDKFTyb0qSpwDDBG75OfCPvR
         Gm8TwY+7t0XPkxRRVbO5guYzN/q0oBpB6iKgt+uW9G3qeUS4ptSixg//eNXDAVPe0bqa
         8OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544717; x=1775149517;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oOBWb7UN+VoG7zLhsMRNH2vdj01IvN0GLyIluMdcf8=;
        b=oq04qDAy0Tv3sfHX9MsVGgQ/sCcwN7Ecl4L/lj4DOQmTCfzdLE3dj/xkr5GC7Nm6y6
         K8dr/4oynlmSiE72+P2N9YU0PZd6SqniJewF6Gf1RjnCQjYwwY5O90i4YohTwsDHG3zN
         Iv8Ha8H7kQd8EfF9yVxyho9UDFQsVA2KELQoXuVALXjzXQaWRK+o7sVJJOU7DWu+hCGg
         JpN1vfM6FbICnKBRRm5khNdcKqzrEmBrUeWMmwphQ8OF/UxLvHpldSd7Tkw/q7Vav+g9
         pP4DPgn/pI0WylshBFW54nNJ3+jeb08+QnKLjHZWoeR6c5iQlAG0WiWAZA6kXGVGrtQT
         fprg==
X-Gm-Message-State: AOJu0Yx44S9K+Te5Grje9FYCIMG2idnshVlGdajSi/FRiok+X68+IxR8
	gLzOcEAPdjsVA4PLg0ONzxXAx9d1q2YwaQ9paj8oVPvbcFCKuLR4ZjmN2r1lWw==
X-Gm-Gg: ATEYQzwamy58nnJcu6XtolzQCjVhdUVbjRcgTv0+HI+b1gfhruniIVr6Ok8T8ayq9XL
	7ZqUa2eAvITHvXMBlW5OOFzY1Hs5NGdGeyQZucGzDU5ePbsWY5+qr5AhD5KsNONsSEwb2f+FKqT
	PU63dVFNoMfh4Ay23Or/m0u3PwxzJAiyQ4fmO1GRsEdgXWCfp9nA+kFA90U/gBGT+VpARRORUvb
	G1Vwrj8CbJ6fl+H9vWz9p//Y7bDo7vwxVrQxhj6ZME7LC93NnF/eG8WwOFpp48C7ikdFYKqrwUX
	o3qNiTCabW4NNpYPvmWWs860tlDTG8tpU58fKK/2hnk7XDmhK7fRiSV3hxNGmcaqWUqtqWfHE5K
	5kkbWae1ACvRnEXQA3pfCcXnSalhkJFgaYDQP/rAhwhgI5tGCcVGNvJ7Xb3xAP4RWwpptoRdj9i
	1Vfw1+ExonyEXQTE0589c1zI4qgjun8sleoz8C36c3
X-Received: by 2002:a05:600c:a409:b0:485:439b:683f with SMTP id 5b1f17b1804b1-48716042aaamr97293335e9.20.1774544717311;
        Thu, 26 Mar 2026 10:05:17 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725d9cf39sm528285e9.17.2026.03.26.10.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 10:05:16 -0700 (PDT)
Message-ID: <e93c0b0d-7d27-4adc-813b-d490fd1b3edb@gmail.com>
Date: Thu, 26 Mar 2026 19:05:15 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 04/12] wifi: rtw89: Fix rtw89_usb_ops_mac_pre_init()
 for RTL8922AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
Content-Language: en-US
In-Reply-To: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33993-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A29BD338E26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Return early because RTL8922AU doesn't need to do anything here.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index eedc8dd2b070..9bd91dc1bb46 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -740,6 +740,9 @@ static int rtw89_usb_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 	const struct rtw89_usb_info *info = rtwusb->info;
 	u32 val32;
 
+	if (rtwdev->chip->chip_id == RTL8922A)
+		return 0;
+
 	rtw89_write32_set(rtwdev, info->usb_host_request_2,
 			  B_AX_R_USBIO_MODE);
 
-- 
2.53.0


