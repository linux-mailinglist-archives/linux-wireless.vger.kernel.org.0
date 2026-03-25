Return-Path: <linux-wireless+bounces-33904-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG0LKqNhxGkuywQAu9opvQ
	(envelope-from <linux-wireless+bounces-33904-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:28:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2411832CFAD
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C50F305C3D9
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A9635DA76;
	Wed, 25 Mar 2026 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKs5fSCk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27F1CFBA
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774477640; cv=none; b=qPdeepxYJazxXnjtEI1NyuOMdAedAt0wmDmrDQ8Xxb1Y8WCUpooUC5vkQ3SplmzqD2P5hFAXBGPkUEJEmgwAV0sssq40fFVS2O4jLGZztwmGyk892ZdHRNHiz/+sXtfkzqoJWEiqCTXFHJfWvGSeBN4E3izcAssnmY8nW43jfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774477640; c=relaxed/simple;
	bh=y3ZU2F/jVCjNIr08pfy6pjHJqUm6eLUOp9BxuAObqAQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hSJqyFGu087zKE7prtDuRlt/fwg17sHX9aVbmiG2wIM9oG+9WzRbB23yvg1HKCKHVvCc+C4cYy9P3qU+ZqK7vSNTsUPm3tRAt1NK4CbC8ZlgorxHxWQCc2HnI/y4n4aHDnlMPH5+0HQceBT9vhXmZiwE/F4flvoufaKmHHGCUis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKs5fSCk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b94a19fdso271939f8f.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 15:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774477637; x=1775082437; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsziCuyUHGvZ0389cHbzb6f478EXgmUcO40P9ACsB8o=;
        b=bKs5fSCkkuXJuwWfOJAvk3JILDlOqqIlmID3yvayRGRjhHg2YnstM06PwKrLDojVGD
         4/iwXgF2qsiICZkd9xYKSZOby8wCv6eTTpMrfFf11EoTGKffGAaJ5YhlNk3fneI7L3xr
         P00s5pUYCSIlstTx9e+nRffIvri8Q8ququw7IP0KK0kT3ypTMo7PkZbHESSEp5Fw3HNy
         +Mp1x1kXPhvwUiUHlVz6Ugcb5HcWaFiq2BvUulCo87Y76JGxur890t0/DzOAgMM/akr+
         4lhp6pV98Zf5tcNFaon1ofpdQnm96RRQ8//CsOUgBFdVFhIs4UzKli+FNgPJCTLzmSS2
         WDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774477637; x=1775082437;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vsziCuyUHGvZ0389cHbzb6f478EXgmUcO40P9ACsB8o=;
        b=K8TQRF9htM906mEdchGbMqnpxwj3YO41wNcFxguwbYPy0mvfdtuVVKf3uRj+KHb0Xx
         cMGbGsktVLVzETCGhnzmdVo7UJF5h05LUNCNHXIpcfDZfLT23FDGTeLarClQTue08jrK
         kB/BMo18fSRulPy+W1jNxdMF0qA90DnOTsva4BEc2D3mMUvwtjLGDc3sfkZJBkzcgK/7
         UinTR00kaK33ORVM6hP1Z+Bb0nxO2/56zPDEVkhOuFHP2+YH0CSyCEoXhqm/W0RGvi+K
         xQNvGetlgapxvpy9E8qd476FMgXUvLeK3+/u7pwUu0TyErpTIy26/nLPbZF+pgYr+u1u
         MhzA==
X-Gm-Message-State: AOJu0YxfIuOKcfhA4e38BZr049PfFVHp4jfjWd/oxOH+yGW7ryD/uMwA
	acgo3++uSzJvxAOagWYMhCGvBgyPei/u1SCk6xlxGSkfZN13xhxZhWdG1r+6aQ==
X-Gm-Gg: ATEYQzyRgkonuTRRdcMxlaBXCy22Nh3a1yEw6RmnnjCVlTYEf2kMoc0Sxk++zuXR+Uo
	oTkCNf7FNuyAyun+GG7jSn5ufNaRB0UVmLZ/4g4n/a9QMKsOjr5IJ2LW9ygCAZ9gMEvJAdLmVNJ
	Dkc8knkR7jCKG+Hl4wPS15Ph6/jUtCksFrYMWbRCBLiaH5nuN65Hg+jFHJaJ1yAXlgynSiGowi3
	jktiPTm9K2l5mgsgs1nMwC/oZgSihPnic9CQgQMdnclH1ARRDBmkGyUi64N14894ZOYwdteBfmx
	0WoOrWKPLh6MmZpvkxvWGEZYu2853nqT7nfoqaHv/GvQEfFdNF6m9tNOOusml4D4Gs0HMU25IwI
	WmpGNYbFOzUPngdBnoKYkP2tN4oeifUyayULn95OFnSr3MxOt5locGvFVfVPJo1w3mPvIO7IZna
	KzEZlRC10E5qpVdcTmitbs9mZwatlrig==
X-Received: by 2002:a05:6000:4212:b0:439:c1f4:302a with SMTP id ffacd0b85a97d-43b8899543emr7643080f8f.11.1774477636791;
        Wed, 25 Mar 2026 15:27:16 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e352sm3154450f8f.3.2026.03.25.15.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 15:27:16 -0700 (PDT)
Message-ID: <bbf06c83-d2ee-4205-8fbb-829e2347586f@gmail.com>
Date: Thu, 26 Mar 2026 00:27:15 +0200
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
Subject: [PATCH rtw-next] wifi: rtw88: coex: Ignore BT info byte 5 from
 RTL8821A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33904-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2411832CFAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sometimes while watching a Youtube video with Bluetooth headphones the
audio has a lot of interruptions, because the 5th byte of the BT info
sent by RTL8821AU has strange values, which result in
coex_stat->bt_hid_pair_num being 2 or 3. When this happens
rtw_coex_freerun_check() returns true, which causes
rtw_coex_action_wl_connected() to call rtw_coex_action_freerun() instead
of rtw_coex_action_bt_a2dp().

The RTL8821AU vendor driver doesn't do anything with the 5th byte of the
BT info, so ignore it here as well.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index ee4007fe6c18..37c336def419 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -3109,6 +3109,9 @@ void rtw_coex_bt_info_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 	for (i = 0; i < COEX_BTINFO_LENGTH; i++)
 		coex_stat->bt_info_c2h[rsp_source][i] = buf[i];
 
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8821A)
+		coex_stat->bt_info_c2h[rsp_source][5] = 0;
+
 	/* get the same info from bt, skip it */
 	if (coex_stat->bt_info_c2h[rsp_source][1] == coex_stat->bt_info_lb2 &&
 	    coex_stat->bt_info_c2h[rsp_source][2] == coex_stat->bt_info_lb3 &&
-- 
2.53.0


