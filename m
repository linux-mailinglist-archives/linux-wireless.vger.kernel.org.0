Return-Path: <linux-wireless+bounces-35324-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK+cLMt37mkGuQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35324-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2026 22:38:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 013EB46B145
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2026 22:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 906F43006781
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2026 20:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B0C38C2D0;
	Sun, 26 Apr 2026 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nluImth6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0758335F5EF
	for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777235905; cv=none; b=nG5xwkqUp1xKFeg3vczW8uU3PSq7QqOtvI8Jm5xC2tiDfELz93SMie0fNuRw30ldMzjLc3D0eg6ifKkaH6PnEINGqnFvBZS9MwLEaOOHNQQaHSnOGkpZMpmy7QjTWX2adEKTKzEdgBLmZ98KR9ouBk/pZBbHqkzWamyD26RqY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777235905; c=relaxed/simple;
	bh=hMxTR5ZTKQQ2ISamtX1Cj+CSdwGsvWifagj23p8yMjo=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=rpcyxPSoaYmfI3EZIgNuq4ZO+LYr391D/2bzUBQE0sT7P3PA0gIMmaz6ONAUu4jbdDaZCNJoAhBNZH1AboH/yq/p9wnwugXQd4bF9aDF2ik8/9HVWza3flExjjFslFz3wFXI5+zDdOBJae0lxPCPPA8qa55bNVhOHAOnp7q34Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nluImth6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so56421975e9.1
        for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 13:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777235902; x=1777840702; darn=vger.kernel.org;
        h=in-reply-to:content-language:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdOn3gqU2Ge8Hdjs/+dkhIDV3Mji0P8pbGuJNu9Jjos=;
        b=nluImth6J2MUlH4o1ML1463Nf5Z3mdQ85245lY6lBxt69QRD8zNmpyJoePWiNF2SaP
         l+q5mrrqA0d61W//Mxudy9i/Z8dpQSSMPQ2dBSmoO4GfR626oYBEnwRYV8xNmBNzNqus
         lsCmMVaz/cugKbnDsYfJfz/gox9QiMOAjacZOEtTPDtGSDFx+i77yxFNZLdLcaIdZ/PT
         dMsZjTuC8dljz2S45vokpx8MJDT6XrQb2DgNMknW9PzUlVoqE6CM8HfbsEtW910VHbDg
         qy/zIq2W1N8a9LQQpRUyOI7zBe6Vdbae1ZxYxP1miI/ALfy8tVFRK4PMpb3WbMUFzx55
         Mwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777235902; x=1777840702;
        h=in-reply-to:content-language:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdOn3gqU2Ge8Hdjs/+dkhIDV3Mji0P8pbGuJNu9Jjos=;
        b=R9ZnucTLIHG2ykh5Y8TRuIF7vC0Wll5Xg5d/PQfqKMs71qXADv1b3Rm6URKL7sifrO
         9DjxkiFJv2jIPu28kBxl2NY7a/WMQncnxJV6C/BCTU7c+mBOscrQVqgEKUF34NZRpCBG
         ciGyZZq/70BhK2ucghubYLfZonbmq1A6qphxbrTYddQVv8zmCeYWP2aGpktxMgzFgYM5
         BNpXF108PAQXVQVHJw7kHjzTE23g1y4fOIFRLsajzBa/3xA5TZo/0E7q0hOw18umt515
         J/+/wVL9tdFfMYwYZp9LikrYt3PuPXjYJF9iDgHM647Hh8AyTVJNK5lgOcEcWNM+kx2s
         XS+w==
X-Gm-Message-State: AOJu0Yxqd09DhdvZXlWypTvuzEAygBPooDlhqRtl2CHRqUqTOunz7W0U
	hILMvf1rVm0lwsvTwyREtILe4OOmbERzGXXUu6nHwd0LhEGeyYYibQT0
X-Gm-Gg: AeBDiethdya9m5F9SLXZ/ei/pUALmZLbz0c0t5NKxyVFXs04R1pq/znM5rCGhG2frEp
	8ssxyDjAQIKs6IYXWeoGxkX18XN6FelU10NsIl4urZmTEQMhGySLRyVDmxBT7FUVB0RM425vYVs
	BFJXwFjEuoi6B2sCIZkdH7O+m6YklC/eysQ6jPi26iAyWiz7eE2+zkKOVP6j9gY8B2UuV+skRjc
	yhG8Irfl0VmwL1T14/dsvZxRvcx2LHXP5ChS+UaOiv9n2TihIxAqfNPBlT6J+27xmyPChYW+ldU
	UifHYkB6fbTibnLIA/r8ckjS0tr/YbnqkFggmG8EFPLg7etpmlXnzbbvyJX7VCuUn3VAxwzFGvu
	gBYu5hDIxghDrLtAnn9U4j6At5PfPEWdlmCzGdAb03AzEXT3aRNXW2ErE9tyef64j5IuBONTX0W
	OqIVBiveRjRMyJbpPNEDzlXrApXEcCV6/pTRL4YV/F
X-Received: by 2002:a05:600c:8b84:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-488fb76e4aamr627380785e9.17.1777235902167;
        Sun, 26 Apr 2026 13:38:22 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489201cde98sm502521165e9.7.2026.04.26.13.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2026 13:38:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------7w27ydMgZXEwuI6I5nnYRl3l"
Message-ID: <faa215f1-ac2c-4072-9603-4baca1d5e07b@gmail.com>
Date: Sun, 26 Apr 2026 23:38:17 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>, LB F <goainwo@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com>
 <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com>
 <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com>
 <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com>
 <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com>
 <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
 <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com>
 <6898154c58c84536a0dd4351b3b026fb@realtek.com>
 <CALdGYqT2e+jt+mK-o_bL8hfdEwqZ44fUt9_N6-H4jYp8FpqQJw@mail.gmail.com>
 <5fb2f699626b483b8a0a537960b274f0@realtek.com>
 <5f9003ca-3bfc-45aa-bf0e-35e9c991629d@gmail.com>
Content-Language: en-US
In-Reply-To: <5f9003ca-3bfc-45aa-bf0e-35e9c991629d@gmail.com>
X-Rspamd-Queue-Id: 013EB46B145
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35324-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[realtek.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is a multi-part message in MIME format.
--------------7w27ydMgZXEwuI6I5nnYRl3l
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2026 17:26, Bitterblue Smith wrote:
> On 31/03/2026 03:32, Ping-Ke Shih wrote:
>>
>> LB F <goainwo@gmail.com> wrote:
>>>
>>> Could you advise on how to investigate this further? For example:
>>>
>>>   - Is there a debug flag or register dump we could capture right
>>>     before the first corrupted frame in a burst?
>>>   - Would it help to log C2H (chip-to-host) traffic around the
>>>     time of these events?
>>
>> I have never heard about this symptom from internal, so no clear
>> idea for that. Sorry.
>>
>>>
>>> I am ready to run any specific tests you need. In the meantime,
>>> I agree that filtering by DRV_INFO_SIZE is the right practical
>>> solution, and I'm waiting for your official patch to test locally.
>>
>> As malformed frames happen randomly, more validations like
>> DRV_INFO_SIZE are needed. I think Bitterblue is working on the
>> test patch. :)
>>
>> Ping-Ke
>>
> 
> Yes, I am preparing a patch now.

Here is the patch, finally.
--------------7w27ydMgZXEwuI6I5nnYRl3l
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-wifi-rtw88-Add-more-validation-for-the-RX-descriptor.patch"
Content-Disposition: attachment;
 filename*0="0001-wifi-rtw88-Add-more-validation-for-the-RX-descriptor.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA5NjEyODc2ZGZkODc0NzA2MGFiMjVkNTkwZDVjMTcyZGVmNjA5MjJmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUy
QGdtYWlsLmNvbT4KRGF0ZTogU3VuLCAyNiBBcHIgMjAyNiAyMToxNTo1MSArMDMwMApTdWJq
ZWN0OiBbUEFUQ0hdIHdpZmk6IHJ0dzg4OiBBZGQgbW9yZSB2YWxpZGF0aW9uIGZvciB0aGUg
UlggZGVzY3JpcHRvcgoKU29tZSBSVEw4ODIxQ0UgY2FyZHMgY2FuIHJldHVybiBmcmFtZXMg
d2l0aCBjb3JydXB0ZWQgUlggZGVzY3JpcHRvciwKY2F1c2luZyB3YXJuaW5ncyBhbmQgY3Jh
c2hlcyBpZiB0aGV5IGFyZSBwYXNzZWQgdG8gdGhlIHVwcGVyIGxheWVycy4KClRoZSBQSFkg
c3RhdHVzIHNpemUgZmllbGQgaXMgNCBiaXRzIHdpZGUsIGJ1dCBpbiBydHc4OCBpdHMgdmFs
dWUgc2hvdWxkCm9ubHkgYmUgMCBvciA0LiBDaGVja2luZyB0aGlzIGNhdGNoZXMgbW9zdCBv
ZiB0aGUgY29ycnVwdCBmcmFtZXMuCgpJZiBhIFBIWSBzdGF0dXMgaXMgcHJlc2VudCwgdGhl
IFBIWSBzdGF0dXMgc2l6ZSBzaG91bGQgbm90IGJlIDAuCgpUaGUgZnJhbWUgc2l6ZSBzaG91
bGQgbm90IGJlIGxlc3MgdGhhbiBvciBlcXVhbCB0byA0IGFuZCBzaG91bGQgbm90CmV4Y2Vl
ZCAxMTQ1NC4KCkRpc2NhcmQgdGhlIGZyYW1lIGlmIGFueSBvZiB0aGVzZSBjaGVjayBmYWls
cy4KCkNsb3NlczogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9p
ZD0yMjEyODYKUmVwb3J0ZWQtYnk6IE9sZWtzYW5kciBIYXZyeWxvdiA8Z29haW53b0BnbWFp
bC5jb20+ClNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJA
Z21haWwuY29tPgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcGNp
LmMgIHwgMTYgKysrKysrKy0tLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg4L3J4LmMgICB8IDMyICsrKysrKysrKysrKysrKysrKysrLS0tCiBkcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J4LmggICB8ICA2ICsrLS0tCiBkcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3NkaW8uYyB8ICA4ICsrKysrLQogZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OC91c2IuYyAgfCAgOSArKysrLS0tCiA1IGZpbGVzIGNo
YW5nZWQsIDU0IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcGNpLmMgYi9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3BjaS5jCmluZGV4IGJiYTM3MGFkNTEwYy4uMzQ0
Zjk1M2YwYTEwIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg4L3BjaS5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcGNp
LmMKQEAgLTEwNDIsMjAgKzEwNDIsMjEgQEAgc3RhdGljIGludCBydHdfcGNpX2dldF9od19y
eF9yaW5nX25yKHN0cnVjdCBydHdfZGV2ICpydHdkZXYsCiBzdGF0aWMgdTMyIHJ0d19wY2lf
cnhfbmFwaShzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCBzdHJ1Y3QgcnR3X3BjaSAqcnR3cGNp
LAogCQkJICAgdTggaHdfcXVldWUsIHUzMiBsaW1pdCkKIHsKKwlzdHJ1Y3QgcnR3X3BjaV9y
eF9yaW5nICpyaW5nID0gJnJ0d3BjaS0+cnhfcmluZ3NbUlRXX1JYX1FVRVVFX01QRFVdOwog
CWNvbnN0IHN0cnVjdCBydHdfY2hpcF9pbmZvICpjaGlwID0gcnR3ZGV2LT5jaGlwOwogCXN0
cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSA9ICZydHdwY2ktPm5hcGk7Ci0Jc3RydWN0IHJ0d19w
Y2lfcnhfcmluZyAqcmluZyA9ICZydHdwY2ktPnJ4X3JpbmdzW1JUV19SWF9RVUVVRV9NUERV
XTsKLQlzdHJ1Y3QgcnR3X3J4X3BrdF9zdGF0IHBrdF9zdGF0OworCXUzMiBwa3RfZGVzY19z
eiA9IGNoaXAtPnJ4X3BrdF9kZXNjX3N6OworCXUzMiBidWZfZGVzY19zeiA9IGNoaXAtPnJ4
X2J1Zl9kZXNjX3N6OwogCXN0cnVjdCBpZWVlODAyMTFfcnhfc3RhdHVzIHJ4X3N0YXR1czsK
KwlzdHJ1Y3QgcnR3X3J4X3BrdF9zdGF0IHBrdF9zdGF0OwogCXN0cnVjdCBza19idWZmICpz
a2IsICpuZXc7CiAJdTMyIGN1cl9ycCA9IHJpbmctPnIucnA7CiAJdTMyIGNvdW50LCByeF9k
b25lID0gMDsKIAl1MzIgcGt0X29mZnNldDsKLQl1MzIgcGt0X2Rlc2Nfc3ogPSBjaGlwLT5y
eF9wa3RfZGVzY19zejsKLQl1MzIgYnVmX2Rlc2Nfc3ogPSBjaGlwLT5yeF9idWZfZGVzY19z
ejsKKwlkbWFfYWRkcl90IGRtYTsKIAl1MzIgbmV3X2xlbjsKIAl1OCAqcnhfZGVzYzsKLQlk
bWFfYWRkcl90IGRtYTsKKwlpbnQgcmV0OwogCiAJY291bnQgPSBydHdfcGNpX2dldF9od19y
eF9yaW5nX25yKHJ0d2RldiwgcnR3cGNpKTsKIAljb3VudCA9IG1pbihjb3VudCwgbGltaXQp
OwpAQCAtMTA2Nyw3ICsxMDY4LDEwIEBAIHN0YXRpYyB1MzIgcnR3X3BjaV9yeF9uYXBpKHN0
cnVjdCBydHdfZGV2ICpydHdkZXYsIHN0cnVjdCBydHdfcGNpICpydHdwY2ksCiAJCWRtYV9z
eW5jX3NpbmdsZV9mb3JfY3B1KHJ0d2Rldi0+ZGV2LCBkbWEsIFJUS19QQ0lfUlhfQlVGX1NJ
WkUsCiAJCQkJCURNQV9GUk9NX0RFVklDRSk7CiAJCXJ4X2Rlc2MgPSBza2ItPmRhdGE7Ci0J
CXJ0d19yeF9xdWVyeV9yeF9kZXNjKHJ0d2RldiwgcnhfZGVzYywgJnBrdF9zdGF0LCAmcnhf
c3RhdHVzKTsKKwkJcmV0ID0gcnR3X3J4X3F1ZXJ5X3J4X2Rlc2MocnR3ZGV2LCByeF9kZXNj
LAorCQkJCQkgICAmcGt0X3N0YXQsICZyeF9zdGF0dXMpOworCQlpZiAocmV0KQorCQkJZ290
byBuZXh0X3JwOwogCiAJCS8qIG9mZnNldCBmcm9tIHJ4X2Rlc2MgdG8gcGF5bG9hZCAqLwog
CQlwa3Rfb2Zmc2V0ID0gcGt0X2Rlc2Nfc3ogKyBwa3Rfc3RhdC5kcnZfaW5mb19zeiArCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J4LmMgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J4LmMKaW5kZXggZDllMTEzNDNk
NDk4Li4zMzQzMzk1ZWY0MjMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvcnguYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg4L3J4LmMKQEAgLTMsNiArMyw3IEBACiAgKi8KIAogI2luY2x1ZGUgIm1haW4uaCIKKyNp
bmNsdWRlICJtYWMuaCIKICNpbmNsdWRlICJyeC5oIgogI2luY2x1ZGUgInBzLmgiCiAjaW5j
bHVkZSAiZGVidWcuaCIKQEAgLTI2MSw5ICsyNjIsOSBAQCBzdGF0aWMgdm9pZCBydHdfcnhf
ZmlsbF9yeF9zdGF0dXMoc3RydWN0IHJ0d19kZXYgKnJ0d2RldiwKIAl9CiB9CiAKLXZvaWQg
cnR3X3J4X3F1ZXJ5X3J4X2Rlc2Moc3RydWN0IHJ0d19kZXYgKnJ0d2Rldiwgdm9pZCAqcnhf
ZGVzYzgsCi0JCQkgIHN0cnVjdCBydHdfcnhfcGt0X3N0YXQgKnBrdF9zdGF0LAotCQkJICBz
dHJ1Y3QgaWVlZTgwMjExX3J4X3N0YXR1cyAqcnhfc3RhdHVzKQoraW50IHJ0d19yeF9xdWVy
eV9yeF9kZXNjKHN0cnVjdCBydHdfZGV2ICpydHdkZXYsIHZvaWQgKnJ4X2Rlc2M4LAorCQkJ
IHN0cnVjdCBydHdfcnhfcGt0X3N0YXQgKnBrdF9zdGF0LAorCQkJIHN0cnVjdCBpZWVlODAy
MTFfcnhfc3RhdHVzICpyeF9zdGF0dXMpCiB7CiAJdTMyIGRlc2Nfc3ogPSBydHdkZXYtPmNo
aXAtPnJ4X3BrdF9kZXNjX3N6OwogCXN0cnVjdCBydHdfcnhfZGVzYyAqcnhfZGVzYyA9IHJ4
X2Rlc2M4OwpAQCAtMzAzLDEyICszMDQsMzMgQEAgdm9pZCBydHdfcnhfcXVlcnlfcnhfZGVz
YyhzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCB2b2lkICpyeF9kZXNjOCwKIAkJcGt0X3N0YXQt
PmJ3ID0gUlRXX0NIQU5ORUxfV0lEVEhfMjA7CiAJfQogCisJaWYgKHVubGlrZWx5KHBrdF9z
dGF0LT5kcnZfaW5mb19zeiAmJgorCQkgICAgIHBrdF9zdGF0LT5kcnZfaW5mb19zeiAhPSBQ
SFlfU1RBVFVTX1NJWkUpKSB7CisJCXByX2Vycl9vbmNlKCJkcnZfaW5mb19zeiAlZFxuIiwg
cGt0X3N0YXQtPmRydl9pbmZvX3N6KTsKKwkJcmV0dXJuIC1FSU5WQUw7CisJfQorCisJaWYg
KHVubGlrZWx5KHBrdF9zdGF0LT5waHlfc3RhdHVzICYmICFwa3Rfc3RhdC0+ZHJ2X2luZm9f
c3opKSB7CisJCXByX2Vycl9vbmNlKCJwaHlfc3RhdHVzIGJ1dCBubyBkcnZfaW5mb19zelxu
Iik7CisJCXJldHVybiAtRUlOVkFMOworCX0KKworCWlmICh1bmxpa2VseShwa3Rfc3RhdC0+
cGt0X2xlbiA+IElFRUU4MDIxMV9NQVhfTVBEVV9MRU5fVkhUXzExNDU0KSkgeworCQlwcl9l
cnJfb25jZSgicGt0X2xlbiAlZFxuIiwgcGt0X3N0YXQtPnBrdF9sZW4pOworCQlyZXR1cm4g
LUVJTlZBTDsKKwl9CisKIAkvKiBkcnZfaW5mb19zeiBpcyBpbiB1bml0IG9mIDgtYnl0ZXMg
Ki8KIAlwa3Rfc3RhdC0+ZHJ2X2luZm9fc3ogKj0gODsKIAogCS8qIGMyaCBjbWQgcGt0J3Mg
cngvcGh5IHN0YXR1cyBpcyBub3QgaW50ZXJlc3RlZCAqLwogCWlmIChwa3Rfc3RhdC0+aXNf
YzJoKQotCQlyZXR1cm47CisJCXJldHVybiAwOworCisJaWYgKHVubGlrZWx5KHBrdF9zdGF0
LT5wa3RfbGVuIDw9IEZDU19MRU4pKSB7CisJCXByX2Vycl9vbmNlKCJub3QgYzJoIHBrdF9s
ZW4gJWRcbiIsIHBrdF9zdGF0LT5wa3RfbGVuKTsKKwkJcmV0dXJuIC1FSU5WQUw7CisJfQog
CiAJcGh5X3N0YXR1cyA9IHJ4X2Rlc2M4ICsgZGVzY19zeiArIHBrdF9zdGF0LT5zaGlmdDsK
IAloZHIgPSBwaHlfc3RhdHVzICsgcGt0X3N0YXQtPmRydl9pbmZvX3N6OwpAQCAtMzE4LDUg
KzM0MCw3IEBAIHZvaWQgcnR3X3J4X3F1ZXJ5X3J4X2Rlc2Moc3RydWN0IHJ0d19kZXYgKnJ0
d2Rldiwgdm9pZCAqcnhfZGVzYzgsCiAJCXJ0d2Rldi0+Y2hpcC0+b3BzLT5xdWVyeV9waHlf
c3RhdHVzKHJ0d2RldiwgcGh5X3N0YXR1cywgcGt0X3N0YXQpOwogCiAJcnR3X3J4X2ZpbGxf
cnhfc3RhdHVzKHJ0d2RldiwgcGt0X3N0YXQsIGhkciwgcnhfc3RhdHVzKTsKKworCXJldHVy
biAwOwogfQogRVhQT1JUX1NZTUJPTChydHdfcnhfcXVlcnlfcnhfZGVzYyk7CmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J4LmggYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J4LmgKaW5kZXggNmI3ZGVlMjQ1YzBhLi43
NDM1OWY2NDFjNzYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODgvcnguaAorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J4
LmgKQEAgLTQ1LDkgKzQ1LDkgQEAgc3RydWN0IHJ0d19yeF9kZXNjIHsKIAogdm9pZCBydHdf
cnhfc3RhdHMoc3RydWN0IHJ0d19kZXYgKnJ0d2Rldiwgc3RydWN0IGllZWU4MDIxMV92aWYg
KnZpZiwKIAkJICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKTsKLXZvaWQgcnR3X3J4X3F1ZXJ5X3J4
X2Rlc2Moc3RydWN0IHJ0d19kZXYgKnJ0d2Rldiwgdm9pZCAqcnhfZGVzYzgsCi0JCQkgIHN0
cnVjdCBydHdfcnhfcGt0X3N0YXQgKnBrdF9zdGF0LAotCQkJICBzdHJ1Y3QgaWVlZTgwMjEx
X3J4X3N0YXR1cyAqcnhfc3RhdHVzKTsKK2ludCBydHdfcnhfcXVlcnlfcnhfZGVzYyhzdHJ1
Y3QgcnR3X2RldiAqcnR3ZGV2LCB2b2lkICpyeF9kZXNjOCwKKwkJCSBzdHJ1Y3QgcnR3X3J4
X3BrdF9zdGF0ICpwa3Rfc3RhdCwKKwkJCSBzdHJ1Y3QgaWVlZTgwMjExX3J4X3N0YXR1cyAq
cnhfc3RhdHVzKTsKIHZvaWQgcnR3X3VwZGF0ZV9yeF9mcmVxX2Zyb21faWUoc3RydWN0IHJ0
d19kZXYgKnJ0d2Rldiwgc3RydWN0IHNrX2J1ZmYgKnNrYiwKIAkJCQlzdHJ1Y3QgaWVlZTgw
MjExX3J4X3N0YXR1cyAqcnhfc3RhdHVzLAogCQkJCXN0cnVjdCBydHdfcnhfcGt0X3N0YXQg
KnBrdF9zdGF0KTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODgvc2Rpby5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9zZGlv
LmMKaW5kZXggMTMxOGU5NGY4NTI0Li41YjQwZDc0YjE2ZWUgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvc2Rpby5jCisrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvc2Rpby5jCkBAIC05OTUsNyArOTk1LDEzIEBAIHN0
YXRpYyB2b2lkIHJ0d19zZGlvX3J4Zmlmb19yZWN2KHN0cnVjdCBydHdfZGV2ICpydHdkZXYs
IHUzMiByeF9sZW4pCiAKIAl3aGlsZSAodHJ1ZSkgewogCQlyeF9kZXNjID0gc2tiLT5kYXRh
OwotCQlydHdfcnhfcXVlcnlfcnhfZGVzYyhydHdkZXYsIHJ4X2Rlc2MsICZwa3Rfc3RhdCwg
JnJ4X3N0YXR1cyk7CisJCXJldCA9IHJ0d19yeF9xdWVyeV9yeF9kZXNjKHJ0d2Rldiwgcnhf
ZGVzYywKKwkJCQkJICAgJnBrdF9zdGF0LCAmcnhfc3RhdHVzKTsKKwkJaWYgKHJldCkgewor
CQkJZGV2X2tmcmVlX3NrYl9hbnkoc2tiKTsKKwkJCXJldHVybjsKKwkJfQorCiAJCXBrdF9v
ZmZzZXQgPSBwa3RfZGVzY19zeiArIHBrdF9zdGF0LmRydl9pbmZvX3N6ICsKIAkJCSAgICAg
cGt0X3N0YXQuc2hpZnQ7CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvdXNiLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4
L3VzYi5jCmluZGV4IDcxODk0MGViYmEzMS4uNmRkOGZmZWRhYjlhIDEwMDY0NAotLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3VzYi5jCisrKyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNiLmMKQEAgLTYxMCw4ICs2MTAsOCBAQCBz
dGF0aWMgdm9pZCBydHdfdXNiX3J4X2hhbmRsZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3Jr
KQogCXUzMiBtYXhfc2tiX2xlbiA9IHBrdF9kZXNjX3N6ICsgUEhZX1NUQVRVU19TSVpFICog
OCArCiAJCQkgIElFRUU4MDIxMV9NQVhfTVBEVV9MRU5fVkhUXzExNDU0OwogCXUzMiBwa3Rf
b2Zmc2V0LCBuZXh0X3BrdCwgc2tiX2xlbjsKKwlpbnQgbGltaXQsIHJldDsKIAl1OCAqcnhf
ZGVzYzsKLQlpbnQgbGltaXQ7CiAKIAlmb3IgKGxpbWl0ID0gMDsgbGltaXQgPCAyMDA7IGxp
bWl0KyspIHsKIAkJcnhfc2tiID0gc2tiX2RlcXVldWUoJnJ0d3VzYi0+cnhfcXVldWUpOwpA
QCAtNjI3LDggKzYyNywxMSBAQCBzdGF0aWMgdm9pZCBydHdfdXNiX3J4X2hhbmRsZXIoc3Ry
dWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCQlyeF9kZXNjID0gcnhfc2tiLT5kYXRhOwogCiAJ
CWRvIHsKLQkJCXJ0d19yeF9xdWVyeV9yeF9kZXNjKHJ0d2RldiwgcnhfZGVzYywgJnBrdF9z
dGF0LAotCQkJCQkgICAgICZyeF9zdGF0dXMpOworCQkJcmV0ID0gcnR3X3J4X3F1ZXJ5X3J4
X2Rlc2MocnR3ZGV2LCByeF9kZXNjLAorCQkJCQkJICAgJnBrdF9zdGF0LCAmcnhfc3RhdHVz
KTsKKwkJCWlmIChyZXQpCisJCQkJYnJlYWs7CisKIAkJCXBrdF9vZmZzZXQgPSBwa3RfZGVz
Y19zeiArIHBrdF9zdGF0LmRydl9pbmZvX3N6ICsKIAkJCQkgICAgIHBrdF9zdGF0LnNoaWZ0
OwogCi0tIAoyLjUzLjAKCg==

--------------7w27ydMgZXEwuI6I5nnYRl3l--

