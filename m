Return-Path: <linux-wireless+bounces-13147-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7FB985802
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8881F21720
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7217D14600D;
	Wed, 25 Sep 2024 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIAXVSqS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D46137775
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727263993; cv=none; b=Sp0a9nc3glpHQ101FZRci4CeXdsyxZtKXVZgqsHsK+gtvgZfzbGbaRaeJNRAPj7kMHEO1ZILozX2nywtx2+ZzoKBHyhcfJWnxP/EnP1gYH3LxS06kT0r6wQLT7WYD/VKQlvp9zBm4jmiJh1cfhGDd4YRADUVPrtUS4w14ipEmh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727263993; c=relaxed/simple;
	bh=tc8uqoCNRNdrD17ZB4QzB7ejHnXWxueD1dikRRayNIA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=X1yafpD7pkORr55s/9CrnE4/jfWoKJrCvFcq5FtE+Pa7Z0Zqx5WQ8NlVtNd9G2LCeUEQPYgNmpg9NGZPqs8xUfh0qwWlMTx2cv66xd+EiK+jmqHpg2gpQUDu5G9/0D05vkbRddFN8iJnbEkwpoCzQ/6RlGxuvnFAxyZXBSSBZ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIAXVSqS; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82aab679b7bso235728939f.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 04:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727263991; x=1727868791; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tc8uqoCNRNdrD17ZB4QzB7ejHnXWxueD1dikRRayNIA=;
        b=ZIAXVSqSGn0YV7iJ4pVLZcv32jkvY5UUqPrNpN1Lo40qbS71pvnmn0JQKdL/o+Qxu5
         r6JEMqHJSP6XTixT4IIN62ya6VfUDtOmWzyvTBSC/4jD1OT3qaX9uZ/7+VHKoYjfeWQt
         JZZVDTHzv/t8Oe/bNw+I09Zzof6z2VtXj5W78W9h6Su3VrQtuTuaJ+cdYOF6vxnLJuRS
         9NSNmibQizXOyMTDM/wj0rq5yQZ57r6f7Aku8PwwoA+NY1YqAjhjYk9U50scUyy66CIf
         dtDOGaJL85MRHTcEbtlOWf74mFXEo2hTXgGP+FFKXVkUF/0Y+5YCb8neYk1JPRMtXSwU
         wG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727263991; x=1727868791;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tc8uqoCNRNdrD17ZB4QzB7ejHnXWxueD1dikRRayNIA=;
        b=eHSM6TtofVgNPx4ORQ9BgkBQuRtb4bm/7981cRDZScgPPAMYJ12DOaml0u6MjMuHy3
         OHY3qWlXBZcUZqqRXikuGRbLdFyWnHAO0m/0ZX+DSc0TZqKbNMMLqgfKmUfdUjZ8YNMQ
         5cTi0p9A0AuZla6d6FsJC9QUf/q+donaQwwZAqh3xcoBt3FV9U/V7cA+Ob0Trz8yZfrW
         XdQy/6jg0sF8Q97QhKTk5aX8fvOJwflB40O+fyT2n0eB+OX8XQFskfl8hYIhJKD1jomT
         UCH9eYR2K07m+0z8N3Q8mh/RB/H43x7UIu0OAgLlByl2F9Ld8Gz1RfVYUeHNgwPNU3cH
         eMKw==
X-Forwarded-Encrypted: i=1; AJvYcCUk9u8JLRoO7i/QqYiupE76QT1I5Q+RW1X0cECoHxJjhZluSDsxmpHaW4J9IifqeiQU0kH8lZe3DjGTAs4wUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9MyBKpplnO/B9X2xL+PLc4OKFp56lomRaqMVKujTCzzyxl6du
	UvUtZZAdbaQdcqUbp8cQwwUGxfZVlWCNBXZNv0EY3vS2MzwMKRXl
X-Google-Smtp-Source: AGHT+IHYHRWH8mBWxmgeETnntNhbzxDj98PIYcEbLrgqoXhejrC12/4mSvk/PAlAQKZ3evNhvlxTFA==
X-Received: by 2002:a05:6602:1694:b0:82d:3c2:9118 with SMTP id ca18e2360f4ac-83247f89baemr302888339f.16.1727263990549;
        Wed, 25 Sep 2024 04:33:10 -0700 (PDT)
Received: from [10.163.199.22] ([64.125.133.166])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40f0e92ddsm991918173.24.2024.09.25.04.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 04:33:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------VLjyUQCgADLx2t4IVYMshR58"
Message-ID: <0d1dab88-66a0-48c1-bdbe-777d07c3132e@gmail.com>
Date: Wed, 25 Sep 2024 04:33:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k/WCN6855 neighbor report request made immediately after
 connection gets no response (with MFP)
To: Baochen Qiang <quic_bqiang@quicinc.com>,
 "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
Cc: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <eb41d8ec-c4f1-474e-a938-099f27aa94e3@gmail.com>
 <fd90d471-503b-4f58-ae11-bae2afab08c7@quicinc.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <fd90d471-503b-4f58-ae11-bae2afab08c7@quicinc.com>

This is a multi-part message in MIME format.
--------------VLjyUQCgADLx2t4IVYMshR58
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQmFvY2hlbiwNCg0KT24gOS8yNS8yNCAzOjA3IEFNLCBCYW9jaGVuIFFpYW5nIHdyb3Rl
Og0KPg0KPiBPbiA5LzE5LzIwMjQgODoyMSBQTSwgSmFtZXMgUHJlc3R3b29kIHdyb3RlOg0K
Pj4gSGksDQo+Pg0KPj4gSSBub3RpY2VkIGFuIGlzc3VlIHdoZW4gd2Ugc3RhcnRlZCBwdXR0
aW5nIGF0aDExayBjbGllbnRzIG9uIGEgV1BBMyBuZXR3b3JrIHdoaWNoIHNlZW1zIHRvIGJl
IHJlbGF0ZWQgdG8gdGhlIGZhY3QgdGhhdCBtYW5hZ2VtZW50IGZyYW1lIHByb3RlY3Rpb24g
aXMgZW5hYmxlZCAod29ya3MgZmluZSBvbiBXUEEyIG5vIE1GUCkuIEltbWVkaWF0ZWx5IGFm
dGVyIGFuIGluaXRpYWwgYXNzb2NpYXRpb24gYSBuZWlnaGJvciByZXBvcnQgcmVxdWVzdCBn
b2VzIG91dCBhbmQgd2UgZ2V0IG5vIHJlc3BvbnNlIGZyb20gdGhlIEFQLiBBZnRlciBnZXR0
aW5nIGEgUENBUCBpbiBvbmUgY2FzZSB3ZSBub3RpY2VkIHRoZSBuZWlnaGJvciByZXBvcnQg
cmVxdWVzdCB3ZW50IG91dCB1bmVuY3J5cHRlZCwgdGhvdWdoIHN0aWxsIGhhZCB0aGUgQ0NN
UCBJViBwYXJhbWV0ZXIuIFRoZSBjb250ZW50IG9mIHRoZSByZXF1ZXN0IHdhcyB0aGUgdW5l
bmNyeXB0ZWQgcmVxdWVzdCwgYW5kIHNvbWV0aGluZyBsaWtlIDE1IGJ5dGVzIG9mIDB4MDAg
cGFkZGluZy4gSSB3aWxsIHNheSwgdGhpcyBpbml0aWFsIFBDQVAgd2FzIG1hZGUgdGhyb3Vn
aCB0aGUgQVAgdmVuZG9yIHNvIHBlcmhhcHMgaXQgYXV0b21hdGljYWxseSBhZGRlZCB0aGUg
cmlnaHQga2V5cyB0byBkZWNyeXB0IHRoZSBmcmFtZSwgdGhpcyBjb3VsZCBiZSBhIHJlZCBo
ZXJyaW5nLiBJIHRyaWVkIG9uIG15IGhvbWUgbmV0d29yayBhbmQgaXQgd2FzIGhpdCBvciBt
aXNzLCBzb21ldGltZXMgSSB3b3VsZCBnZXQgYSByZXNwb25zZSBidXQgc29tZXRpbWVzIEkg
d291bGRuJ3QsIGJ1dCBJIGRpZCBzZWUgdGhlIGZyYW1lIHdhcyBhbHdheXMgZW5jcnlwdGVk
IGluIG15IGhvbWUgbmV0d29yayBjYXNlIHRob3VnaCB3aGVuIGFkZGluZyB0aGUgUE1LIGRp
cmVjdGx5IGluIHdpcmVzaGFyayBJIGNvdWxkbid0IGRlY3J5cHQgaXQsIHdoZXJlIG9uIG90
aGVyIGhhcmR3YXJlIGxpa2UgaXdsd2lmaSBJIGNvdWxkLg0KPiBpcyB5b3VyIGhvbWUgbmV0
d29yayBhbHNvIFdQQTM/DQo+DQo+IGFuZCBob3cgZGlkIHlvdSBnZXQgdGhlIFBNSz8gaXMg
aXQgZ2VuZXJhdGVkIGJ5IElXRCBhbmQgcHJpbnRlZCBhcyBkZWJ1ZyBtZXNzYWdlPw0KDQpJ
IGFjdHVhbGx5IGhhZCB0byBtb2RpZnkgSVdEIHRvIHByaW50IG91dCB0aGUgUE1LIGFmdGVy
IGl0IGRlcml2ZWQgaXQuIA0KV1BBMyBtYWtlcyB0aGlzIGEgaHVnZSBwYWluIHNpbmNlIHRo
ZSBQTUsgZGlmZmVycyBiZXR3ZWVuIFNBRSBleGNoYW5nZXMuDQoNCkkndmUgYXR0YWNoZWQg
YW4gSVdEIGRpZmYgdGhhdCBwcmludHMgb3V0IHRoZSBQTUssIHdoaWNoIGNhbiBiZSBhZGRl
ZCB0byANCndpcmVzaGFyayBpZiB0aGF0IGhlbHBzLg0KDQo+DQo+PiBTb21lIHRpbWUgYWZ0
ZXIgdGhlIGNvbm5lY3Rpb24gbmVpZ2hib3IgcmVwb3J0cyB3b3JrIGZpbmUuIEknbSBub3Qg
c3VyZSBvZiBhIHRpbWUgZnJhbWUgb3IgZGVsYXkgcmVxdWlyZWQgdGhhdCBnZXRzIHRoZW0g
d29ya2luZywgYnV0IGl0IG1ha2VzIG1lIHN1c3BlY3QgdGhhdCBhdGgxMWsgZG9lc24ndCBo
YXZlIHRoZSBrZXlzIGZ1bGx5IGFkZGVkIGluIHRoZSBmaXJtd2FyZSBiZWZvcmUgdXNlcnNw
YWNlIGdldHMgc2lnbmFsZWQgYXMgImNvbm5lY3RlZCIuIFJ1bm5pbmcgdGhlIHNhbWUgc2Nl
bmFyaW8gb24gYXRoMTBrIG9yIGl3bHdpZmkgaGFzIG5vIGlzc3Vlcy4gVGhpcyBuZWlnaGJv
ciByZXBvcnQgcmVxdWVzdCBpbW1lZGlhdGVseSBhZnRlciBjb25uZWN0aW5nIGlzIElXRCdz
IGRlZmF1bHQgYmVoYXZpb3IsIHNvIGl0cyByZWxhdGl2ZWx5IGVhc3kgdG8gdGVzdCBieSBq
dXN0IHJlc3RhcnRpbmcgSVdELg0KPiBJIGNhcHR1cmVkIGEgV1BBMyBTQUUgUENBUCB0b28s
IGJ1dCBvbmx5IGNhbiBmaW5kIHNvbWUgdW5lbmNyeXB0ZWQgQUREQkEgcmVxL3Jlc3AgZnJh
bWVzLiBmb3IgdGhvc2UgZW5jcnlwdGVkIGFjdGlvbiBmcmFtZXMgSSBhbSBzdGlsbCBzdHJ1
Z2dsaW5nIHRvIGRlY3J5cHQgdGhlbQ0KPg0KPj4gU2luY2UgdGhlIG5laWdoYm9yIHJlcG9y
dHMgd29yayBmaW5lIGFmdGVyIHNvbWUgdGltZSBpdHMgbm90IHJlYWxseSBhIGNyaXRpY2Fs
IGlzc3VlIGJ1dCBJIHdhbnRlZCB0byBicmluZyBpdCB1cCBqdXN0IGluIGNhc2UuDQo+Pg0K
Pj4gVGhhbmtzLA0KPj4NCj4+IEphbWVzDQo+Pg0K
--------------VLjyUQCgADLx2t4IVYMshR58
Content-Type: text/x-patch; charset=UTF-8; name="print-pmk.patch"
Content-Disposition: attachment; filename="print-pmk.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3NyYy9zYWUuYyBiL3NyYy9zYWUuYwppbmRleCA5N2MwYWYwNS4uZjJj
ZWJlMDkgMTAwNjQ0Ci0tLSBhL3NyYy9zYWUuYworKysgYi9zcmMvc2FlLmMKQEAgLTg1Nyw2
ICs4NTcsMjAgQEAgc3RhdGljIGJvb2wgc2FlX3ZlcmlmeV9jb25maXJtKHN0cnVjdCBzYWVf
c20gKnNtLCBjb25zdCB1aW50OF90ICpmcmFtZSkKICAgICAgICByZXR1cm4gdHJ1ZTsKIH0K
IAorI2luY2x1ZGUgPHN0ZGlvLmg+CisKK3N0YXRpYyB2b2lkIHByaW50X3Btayh1aW50OF90
ICpwbWspCit7CisgICAgICAgdW5zaWduZWQgaW50IGk7CisKKyAgICAgICBwcmludGYoIlBN
SzogIik7CisKKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgMzI7IGkrKykKKyAgICAgICAgICAg
ICAgIHByaW50ZigiJTAyeCIsIHBta1tpXSk7CisKKyAgICAgICBwcmludGYoIlxuIik7Cit9
CisKIHN0YXRpYyBpbnQgc2FlX3Byb2Nlc3NfY29uZmlybShzdHJ1Y3Qgc2FlX3NtICpzbSwg
Y29uc3QgdWludDhfdCAqZnJvbSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b25zdCB1aW50OF90ICpmcmFtZSwgc2l6ZV90IGxlbikKIHsKQEAgLTg4MCw2ICs4OTQsOCBA
QCBzdGF0aWMgaW50IHNhZV9wcm9jZXNzX2NvbmZpcm0oc3RydWN0IHNhZV9zbSAqc20sIGNv
bnN0IHVpbnQ4X3QgKmZyb20sCiAgICAgICAgaGFuZHNoYWtlX3N0YXRlX3NldF9wbWtpZChz
bS0+aGFuZHNoYWtlLCBzbS0+cG1raWQpOwogICAgICAgIGhhbmRzaGFrZV9zdGF0ZV9zZXRf
cG1rKHNtLT5oYW5kc2hha2UsIHNtLT5wbWssIDMyKTsKIAorICAgICAgIHByaW50X3Btayhz
bS0+cG1rKTsKKwogICAgICAgIHNtLT5zdGF0ZSA9IFNBRV9TVEFURV9BQ0NFUFRFRDsKIAog
ICAgICAgIGlmICghc20tPmhhbmRzaGFrZS0+YXV0aGVudGljYXRvcikgewoK

--------------VLjyUQCgADLx2t4IVYMshR58--

