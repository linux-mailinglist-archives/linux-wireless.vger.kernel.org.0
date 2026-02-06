Return-Path: <linux-wireless+bounces-31623-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g64rB1kshmnkKAQAu9opvQ
	(envelope-from <linux-wireless+bounces-31623-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 19:00:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 617B4101908
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 19:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AC753019BB6
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 18:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984AE22156C;
	Fri,  6 Feb 2026 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6b71JLq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237E217993
	for <linux-wireless@vger.kernel.org>; Fri,  6 Feb 2026 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400854; cv=none; b=hiYQP6UawIv5ndbH9yRcwAizi97zkcHLyQjkDiqGaqHz4VSJF35ajX71H4DwEA80cvax8GCHr1FJInRTXLnCd66WKCU/TmxjTW3hpmlhdK21lgX2syeNf+jSyM6rDwI7cyB8qmw4sVNat6J7lEC2o6UIJMqZA4POUKGL85R4+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400854; c=relaxed/simple;
	bh=mJ4thdIrZ7N39ZdGTijFeGTV8F8aU3jvvDKtvSIIXpI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=cNUoRms5g/q/DVI1280+e+3I8ZdEpgPuSjKvhnBXXLlteie0bIBwHg3GZgIGQS5DRYxLxqKZS/UDu36nzBcbXD+rfYKybcWqbst3DIVCjGZd9y98AAGEu8vDW9MyTLF71K0xh9rEPDOoZK2JOkdmTx9TYY5/xj6hZKyyB+MSJuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6b71JLq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43626796202so1608539f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 06 Feb 2026 10:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770400852; x=1771005652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVEIUV67jdz82wJrDpjLcwxRSy1Cg0lfzYAw2ZxWpgc=;
        b=g6b71JLq5bKZH+MyoX94UP25xfIlMcKHo2msfMfnPB9oz3lDidQFJ/b22DfR1YhsQm
         jZURpgTGhnHTLKqaedEOWKa9YOhpbB9SpSdAxgw9IXng71N6GRVyMigC5nXkFN+H3zVj
         6JnxF9gyjAC83NieAbgOq+bv/6wAqSpDY0aFDUQkcn5Nfmh/HX8vnp53SVbNX8StPBOf
         0APE5WamV4hy3h0Wr9U/Y6ewpL6qwcwA/nRfacS1ZqQVacUAZyPEjMkidBDC8wtsHD1S
         MRMzzqGt8/Tj0m/9Ws7Hr0llKVTljzgI/zuzWNLdM6c35xdHQ/GEadJ1Ov22KXxv0Sgv
         ncXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770400852; x=1771005652;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVEIUV67jdz82wJrDpjLcwxRSy1Cg0lfzYAw2ZxWpgc=;
        b=XZ7lwF/uOmCdK95dGCzVdoqcM+YxVaJs1IbUNtx7lT/808dscQgAWWThsU1kNQWK28
         i+6B0Z8SxziJv2YT0TBP8vsUKUtYzOGUXyHihF/a1oVT0JCv4y+FKCXxMG3+RVbqTobm
         gYGdBU7IkVFio6mm6S+FeXTkU4+17yYPU0rxwIstfaQgL8QA9c2CfC7NAVXhxLsMrPhh
         2PD6LhKihqIuC5i/QLxAsnzTcnS1QvS9iFZHX49TukQVSsHrhNcP75O59WvPeJL6adlR
         ZDEasUI1I8L6cOb9Gza5B8Sg2q1vAFPMxlXNSVWadFcl8qOy3fJrIH2HT+9PQV4mW4KG
         mfFQ==
X-Gm-Message-State: AOJu0YwF8ySURzqGXtdEiYq3psd3ywODtwgmQMNx0rtKwgBSLvAkk5/e
	g1eqfc+x6phgUlc3h476TH0YWCAuSyZ3pn4qKyNvWn6c7fx60XB//4ZKuEYInQ==
X-Gm-Gg: AZuq6aJCPe6TXVvNMA7WiGIH0+4m4L/U7MjSCNF+TXkIGNd0yU5Wz5iw8Td3nQ4lkd1
	yOURRBXvv6GUN29bXz+Cn/zkYqVoBcQCqU5nwM+yyB31LeAxps0zIupygt2swaZMGoQ06wXyd4O
	2ycDF8VR5p0FVtY1l3IQxHtu2rqUsM5L/AJJMhgF6Q4uax7RGzyy/+kL70Obj65moFcJqG87qAi
	08Kl/fqKqZx5f4si+T5mjF5JGXi+p6JvL0DC/bsbHqRPZgs+aSsUBD0L4/zv0k4rIh7nLe0WlYv
	kDsJttIZqMgARdL+w1xduMF8Tb57nkK6Be7IWdwwLtoU+3cYcO2RvA9nRXw3gAFb4QH75Ogj2Or
	izrqbftPBCD7kmV0m5BNEM2kDRgwreX2u045JhMqSxsKbdoGUDE8hag/tuifHnfwUcOAc6xC7Uj
	lSH/8yIVYXrVR/u1lP2ORhHwJVcdEv
X-Received: by 2002:a5d:5f50:0:b0:432:b956:663e with SMTP id ffacd0b85a97d-4362937bd2cmr5817514f8f.52.1770400851924;
        Fri, 06 Feb 2026 10:00:51 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43631c8d378sm800865f8f.21.2026.02.06.10.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 10:00:51 -0800 (PST)
Message-ID: <98129317-7e88-4654-910b-630aa992bfa3@gmail.com>
Date: Fri, 6 Feb 2026 20:00:48 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next] wifi: rtw88: WARN only once in
 rtw_phy_get_tx_power_limit()
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31623-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 617B4101908
X-Rspamd-Action: no action

This function WARNs when the wifi band, channel number, channel width,
rate, or RF path are invalid. Two or three people have reported that it
floods the kernel log with warnings because they try to switch to
invalid channel numbers, like 130.

One warning is probably enough, so turn WARN into WARN_ONCE.

Closes: https://github.com/lwfinger/rtw88/issues/428
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index e2ac5c6fd500..2a3929561664 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -2210,8 +2210,8 @@ static s8 rtw_phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
 	return power_limit;
 
 err:
-	WARN(1, "invalid arguments, band=%d, bw=%d, path=%d, rate=%d, ch=%d\n",
-	     band, bw, rf_path, rate, channel);
+	WARN_ONCE(1, "invalid arguments, band=%d, bw=%d, path=%d, rate=%d, ch=%d\n",
+		  band, bw, rf_path, rate, channel);
 	return (s8)rtwdev->chip->max_power_index;
 }
 
-- 
2.52.0


