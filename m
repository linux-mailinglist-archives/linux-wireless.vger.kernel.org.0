Return-Path: <linux-wireless+bounces-29368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BFEC8CF8A
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 07:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD5464E331A
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 06:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE6327A130;
	Thu, 27 Nov 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bestosotech.com header.i=@bestosotech.com header.b="EyNlpTJN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from hs9.name.tools (hs9.name.tools [169.60.152.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDF622F76F;
	Thu, 27 Nov 2025 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.60.152.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764226538; cv=none; b=JG62zdVQwARNSlWBsn9iHw2OtOenEfIIn6uVHmohTtY2EWSakbBv/5dnK4rIKuqw8/Lo+tcoH4LqTXR4GneobBe5zvLUUCVU2bmM7oerELuTmjgYr4ZEzH7oOtvZJCQKnxB1XB5ftVhaMTHa7bpUJV0o9oRAhvZm4DKrNSfNsmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764226538; c=relaxed/simple;
	bh=rOhKFsiQuvXgQfyuE14kr0wb3OkmDoJIMS9M752YQdU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Gy6BNzgWdIbHLCykWQaRzcUOOo6S2AMuZhafT8LkciM72IHxpUvVGp3z1SVPnR/+GWVBSgHdzKZX1BT8m8uT7lmC5KBJoqaUzWlqGqFOF1E2UfjV8Ni6arTLXNiLa3ATW5u1Es1h7AMIHsVBCWRoHSSznuDIgwlPjaUxe6rF2es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bestosotech.com; spf=fail smtp.mailfrom=bestosotech.com; dkim=pass (2048-bit key) header.d=bestosotech.com header.i=@bestosotech.com header.b=EyNlpTJN; arc=none smtp.client-ip=169.60.152.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bestosotech.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=bestosotech.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=bestosotech.com; s=default; h=In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KDOLxuUdZih+MZd4unjdzm7bOLIzAU7VRC8p6dxl4Lg=; b=EyNlpTJNz1aNr+55KUNEY7adup
	uuPyvdG1qfGQ7d3R6R2pkFqUaGqIJ3tTkaCtZ5paMN5b31oe0xmtGWNsld7h1UNmZSa9IT/ztTIM+
	erVc5NBzOvBGmbHMD1ncpGwLSQfG89sV6f0cwq0aJ2UOAzGfRfJBEqzZimbB/ZZtNN7dq04bbT9PU
	kuXQZuMi3PgfyKm2h7SDQMkUTK8SYQlF2UUPktwgTfYQBfLDM3dJ5jZFVG+0Ye52AfDdPl78bWbFo
	M/JRMY0i/2PQhGOs70zmHpa8RyfCog7HurMZaewJjaqvzKmHTTAXYW88yJeyqM3P7tvoAHMJA67Mo
	PWCYhSaQ==;
Received: from mailnull by hs9.name.tools with spam-scanner (Exim 4.98.2)
	(envelope-from <alexbestoso@bestosotech.com>)
	id 1vOVuh-0000000CKn2-1eRW;
	Wed, 26 Nov 2025 23:55:35 -0700
X-ImunifyEmail-Filter-Score: -5.75
X-ImunifyEmail-Filter-Info: TUlNRV9CQVNFNjRfVEVYVCBJRV9WTF9BR0VfRE9NQUlOXzJE
	IElFX1Z
		MX0FHRV9FTUFJTF8yRCBNSURfUkhTX01BVENIX0ZST00gTUlNRV9UUk
		FDRSBNSU1FX1VOS05PV04gUkNWRF9UTFNfQUxMIEZST01fSEFTX0ROI
		FJDVkRfVklBX1NNVFBfQVVUSCBIQVNfQVRUQUNITUVOVCBBUkNfTkEg
		UkNQVF9DT1VOVF9USFJFRSBUT19ETl9FUV9BRERSX1NPTUUgRlJPTV9
		FUV9FTlZGUk9NIFRPX01BVENIX0VOVlJDUFRfU09NRSBWRVJJTE9DS1
		9DQiBUT19ETl9TT01FIFJDVkRfQ09VTlRfT05FIElFX1ZMX0FHRV9BQ
		0NPVU5UXzJEIE1JTUVfQkFTRTY0X1RFWFRfQk9HVVMgWE1fVUFfTk9f
		VkVSU0lPTiBJRV9WTF9BR0VfQUNDT1VOVF8yVyBJRV9WTF9BR0VfRE9
		NQUlOXzJXIElFX1ZMX0FHRV9FTUFJTF8yVw==
X-ImunifyEmail-Filter-Version: 3.8.20/202511211447
X-ImunifyEmail-Filter-Action: no action
Received: from ip184-188-225-63.ri.ri.cox.net ([184.188.225.63]:56402 helo=[192.168.0.172])
	by hs9.name.tools with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <alexbestoso@bestosotech.com>)
	id 1vOVug-0000000CKmM-2DY0;
	Wed, 26 Nov 2025 23:55:34 -0700
Content-Type: multipart/mixed; boundary="------------JD0OAc2JGmBSSm8ts9nkUl0F"
Message-ID: <fcd02348-804c-459b-aa03-de61931516be@bestosotech.com>
Date: Thu, 27 Nov 2025 01:55:33 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug Report - Rtlwifi
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <85517aee-6e2a-4524-a5e2-6b48d05facbe@bestosotech.com>
 <0b376fdcc68442f7b41268bb26cce73e@realtek.com>
Content-Language: en-US
From: alex bestoso <alexbestoso@bestosotech.com>
In-Reply-To: <0b376fdcc68442f7b41268bb26cce73e@realtek.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hs9.name.tools
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bestosotech.com
X-Get-Message-Sender-Via: hs9.name.tools: authenticated_id: alexbestoso@bestosotech.com
X-Authenticated-Sender: hs9.name.tools: alexbestoso@bestosotech.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

This is a multi-part message in MIME format.
--------------JD0OAc2JGmBSSm8ts9nkUl0F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Never made a patch before; but I believe that this is correct, made with git

Sent as attachment and pasted below:


 From 523d3c06eee93db74125b17b5c883ad2c58fcbd5 Mon Sep 17 00:00:00 2001
From: Morning Star <alexbestoso@gmail.com>
Date: Thu, 27 Nov 2025 01:49:39 -0500
Subject: [PATCH] check tid is less than MAX_TID_COUNT

---
  drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c 
b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
index aa702ba7c9f5..fbd9cebb717a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
@@ -511,7 +511,8 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
      if (sta) {
          sta_entry = (struct rtl_sta_info *)sta->drv_priv;
          tid = ieee80211_get_tid(hdr);
-        agg_state = sta_entry->tids[tid].agg.agg_state;
+        if(tid < MAX_TID_COUNT)
+            agg_state = sta_entry->tids[tid].agg.agg_state;
          ampdu_density = sta->deflink.ht_cap.ampdu_density;
      }

-- 
2.34.1



On 11/27/25 01:37, Ping-Ke Shih wrote:
> alex bestoso <alexbestoso@bestosotech.com> wrote:
>> Bug Description :
>>      Index out of range. Problem happens on it's own after being connected to a network for a short while.
>>
>> Error message :
>>      UBSAN: array-index-out-of-bounds in drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c:514:30
>>      [  454.351041] index 10 is out of range for type 'rtl_tid_data [9]'
>>
>> Kernel Version :
>>      6.18.0-rc6+
>>
>> Suggested Solution:
>>      change the file drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c from
>>
>>      513     tid = ieee80211_get_tid(hdr);
>>      514     agg_state = sta_entry->tids[tid].agg.agg_state;
>>      515     ampdu_density = sta->deflink.ht_cap.ampdu_density;
>>
>>      to
>>
>>      513     tid = ieee80211_get_tid(hdr);
>>      514     if(tid < MAX_TID_COUNT)
>>      515         agg_state = sta_entry->tids[tid].agg.agg_state;
>>      516     ampdu_density = sta->deflink.ht_cap.ampdu_density;
> This change is fine to me. Can you send a patch?
>
--------------JD0OAc2JGmBSSm8ts9nkUl0F
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-check-tid-is-less-than-MAX_TID_COUNT.patch"
Content-Disposition: attachment;
 filename="0001-check-tid-is-less-than-MAX_TID_COUNT.patch"
Content-Transfer-Encoding: base64

RnJvbSA1MjNkM2MwNmVlZTkzZGI3NDEyNWIxN2I1Yzg4M2FkMmM1OGZjYmQ1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNb3JuaW5nIFN0YXIgPGFsZXhiZXN0b3NvQGdtYWls
LmNvbT4KRGF0ZTogVGh1LCAyNyBOb3YgMjAyNSAwMTo0OTozOSAtMDUwMApTdWJqZWN0OiBb
UEFUQ0hdIGNoZWNrIHRpZCBpcyBsZXNzIHRoYW4gTUFYX1RJRF9DT1VOVAoKLS0tCiBkcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5MmN1L3RyeC5jIHwgMyAr
Ky0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5
MmN1L3RyeC5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgx
OTJjdS90cnguYwppbmRleCBhYTcwMmJhN2M5ZjUuLmZiZDljZWJiNzE3YSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJjdS90cngu
YworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5MmN1
L3RyeC5jCkBAIC01MTEsNyArNTExLDggQEAgdm9pZCBydGw5MmN1X3R4X2ZpbGxfZGVzYyhz
dHJ1Y3QgaWVlZTgwMjExX2h3ICpodywKIAlpZiAoc3RhKSB7CiAJCXN0YV9lbnRyeSA9IChz
dHJ1Y3QgcnRsX3N0YV9pbmZvICopc3RhLT5kcnZfcHJpdjsKIAkJdGlkID0gaWVlZTgwMjEx
X2dldF90aWQoaGRyKTsKLQkJYWdnX3N0YXRlID0gc3RhX2VudHJ5LT50aWRzW3RpZF0uYWdn
LmFnZ19zdGF0ZTsKKwkJaWYodGlkIDwgTUFYX1RJRF9DT1VOVCkKKwkJCWFnZ19zdGF0ZSA9
IHN0YV9lbnRyeS0+dGlkc1t0aWRdLmFnZy5hZ2dfc3RhdGU7CiAJCWFtcGR1X2RlbnNpdHkg
PSBzdGEtPmRlZmxpbmsuaHRfY2FwLmFtcGR1X2RlbnNpdHk7CiAJfQogCi0tIAoyLjM0LjEK
Cg==

--------------JD0OAc2JGmBSSm8ts9nkUl0F--


