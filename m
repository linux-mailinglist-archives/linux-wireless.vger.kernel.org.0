Return-Path: <linux-wireless+bounces-31637-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mvaKGfi8h2kkcwQAu9opvQ
	(envelope-from <linux-wireless+bounces-31637-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Feb 2026 23:30:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B251F10755F
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Feb 2026 23:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 237FB300EF87
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Feb 2026 22:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AFB28725F;
	Sat,  7 Feb 2026 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ka5wbUZR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF025309F0B
	for <linux-wireless@vger.kernel.org>; Sat,  7 Feb 2026 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770503413; cv=none; b=c1DhULkMZfv0+/6OjSZWD99FGU4oxooz5FV3VqWPH+YUFYylEcCmmJNxZMfc1Wlfn5fBJt3Yd+HahkXA004ufEvAxVR7MeEid71tHIM7o3aqBZMLHldImAuJVoznImDc3s2AmJJI5kE6rVIqZS1MLCWTGKOPIMeczdHkqpYfqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770503413; c=relaxed/simple;
	bh=7v3AxGyBvHbfuA6pdx0IDK98LY3zW3GIM2sdG4PrBwM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CE1oifHAkf9qb3iPWDqBiA45UeAywk9o3qIBPzcERq0mLX4me8rVessBSJzSvb8Crf+JVg4l7Hpjq+oS4ZtcRyGpoudwyW/HAEZoja8PWQcfM5FNGyJasmOK9pIS8Q7ELx7yzG4gBNMNB6t6f4vIhmi0DzImtwnS6EArKCpAZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ka5wbUZR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48069a48629so30304445e9.0
        for <linux-wireless@vger.kernel.org>; Sat, 07 Feb 2026 14:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770503411; x=1771108211; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqfUMfsBXC7a3oPY/nADyoGdbqMebccuzMJ3yISilPE=;
        b=Ka5wbUZRFJCs23aRP8bcktm9PF8fy32v/ekVMw/89MzIPROzzNobaHO8QviF3mlEnP
         H0v7YMqy5+LWJaMMeSfZvG++/La/tvyJQpG6v6dvfPL93GXz7Iov6GYnsBSWkRpSxax8
         8CWcFEK07Ctb5rrWQ3sGKsA0rvguINHCbvBIac8lNe+W1el3vOwQVscvvFT/niOD8I7w
         yk2Nbyt92y07HqbydRdGh+iFns3rsn/oTi9LfN0mj5El2fhPnAls8xCQq1lXPHKAjqbi
         C/XOj03qzDEsUoI1VOXPZCv7Mdi8Q1q4MnkrirDDGYvH2ObA5WaKtwD9r8nC9WQoswUu
         aJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770503411; x=1771108211;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lqfUMfsBXC7a3oPY/nADyoGdbqMebccuzMJ3yISilPE=;
        b=BC3TBi5IJrjorSrHrCfDbWftM6OooHLBM9ci+rkGgLlWOVF54blA5wmxmkHIL3uhoJ
         QzOtVx62Q7hOBVvFIi+7Bpexm3WGMd0YJ1EhDaWecfRg+FANhLKzbPNSMwCmjmYeg/Go
         S7kLvXoVDEd6ZBtGnioGdR3YQG9+ltc9RtDgIOiC9JhlJSGMYrA/z3tf+dCRk+ff7wM2
         aTCqMFU6HLbUabuT/9+Nhc/VbD+T4oc8xmbGzx4eEpLIoD/Fmlba9vELzCNQ0zko80Zj
         IYHzePRgxe/SSPVCgUPwBPw6MIetVZCnknch2cVWmGMfbJ2oxE8pv/l+LTqacH+Bo276
         lQrw==
X-Gm-Message-State: AOJu0YyMJkg7s67/LH043joLV0g5DIhxa4p5+rTNsZEp86sOLwlJBDIT
	ORuwdAHvmzi+klx7tD5dvR6iM7OLaQx+im5C5R1SUXcZ2zYNw7O6DtHyyTfZaA==
X-Gm-Gg: AZuq6aJdc2yBBoK6btduv8trI0InLsg3gTfuo8xmsD/xadVyzfE/kyHNRzEhaTcZonB
	dvX9CxRmhuttYOhnNbSdFGobIVVTlW17dT4xc8cHMLkUm/MTWxt9VT2t1NrAqE0IRg7oF5lwFrl
	vmDTOREv8LkUhGcB0o7gejP6ZS8PUF8jqVWk5atlCbxJc9hpMHt3EQILwv94Tzf+3ehJFYNm7Pm
	6Sp89Q2vzFtXJWf+gw6XvTZ5R+RaFlLTcal1BbOM01dyc/nD7LoZFEzIE2v3xZ6bc88OagNOOPL
	MJTHaLSzKuubdVnEi9kSQRTtoGuLBfcz7CVT3ABgYesT5j31N70CyQfahCoRbIAAGjKc9ivEwF9
	kq8oAFiAM3k6otKVkQpsZTT8K0aDLLanJOO0HE1NyMbu7/KwABiHnIhkCDPr6DBmui5faMzlYkp
	uEtA1dV1GCpxuT0kw17BM5x7Y0pKT+
X-Received: by 2002:a05:600c:3553:b0:475:da1a:5418 with SMTP id 5b1f17b1804b1-483201dc49emr94994195e9.1.1770503410891;
        Sat, 07 Feb 2026 14:30:10 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d299bfsm202220125e9.2.2026.02.07.14.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 14:30:09 -0800 (PST)
Message-ID: <4fc30feb-5616-4e2e-86d8-0d96e4f191c2@gmail.com>
Date: Sun, 8 Feb 2026 00:29:59 +0200
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
Subject: [PATCH rtw-next] wifi: rtw88: Ignore TX report sequence number from
 the 8051 chips
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31637-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B251F10755F
X-Rspamd-Action: no action

When connected to a network in the 2.4 GHz band, wpa_supplicant (or
NetworkManager?) triggers a scan every five minutes. During these scans
mac80211 transmits many QoS Null frames in quick succession. Because
these frames are marked with IEEE80211_TX_CTL_REQ_TX_STATUS, rtw88
asks the firmware to report the TX ACK status for each of these frames.
Sometimes the firmware can't process the TX status requests quickly
enough, they add up, it only processes some of them, and then marks
every subsequent TX status report with the wrong number.

The symptom is that after a while the warning "failed to get tx report
from firmware" appears every five minutes.

This problem apparently happens only with the older RTL8723D, RTL8821A,
RTL8812A, and probably RTL8703B chips. Ignore the TX report sequence
number reported by these chips and match the reports with the requests
in the order they come in.

Tested with RTL8821AU and RTL8723DU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index c04ff31d0f1e..98215ecc884a 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -248,7 +248,7 @@ void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb, int src)
 	spin_lock_irqsave(&tx_report->q_lock, flags);
 	skb_queue_walk_safe(&tx_report->queue, cur, tmp) {
 		n = (u8 *)IEEE80211_SKB_CB(cur)->status.status_driver_data;
-		if (*n == sn) {
+		if (*n == sn || rtw_chip_wcpu_8051(rtwdev)) {
 			__skb_unlink(cur, &tx_report->queue);
 			rtw_tx_report_tx_status(rtwdev, cur, st == 0);
 			break;
-- 
2.52.0


