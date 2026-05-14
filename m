Return-Path: <linux-wireless+bounces-36415-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAX+B4GMBWo5YQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36415-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 10:49:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A719953F789
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 10:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 666693017441
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2026 08:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1623D88EF;
	Thu, 14 May 2026 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cXrFWDZl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZVpvrRJg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8873DD516
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778748540; cv=none; b=FvzWPSJSQ5VrrTCBgd7RM85YRVYZ8BAiyYkcKWqzNrrppvvYfuvRGpMX0/4fl6220p44BlV+Rk0M0QtN/AHrVy0i6huK1dRWqljK854HXlcgK2xGb97xIZZFIGfxpbN9JAQRiUPkoFeJuw7kLytcbSmy+ExNo0kpNxyBGqF+mRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778748540; c=relaxed/simple;
	bh=EgDwSfoHlPR4BzQVDlImDB1JZ9TsM+Jv3+MUyy8Okhw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=EQC/9aF+VLAiBM7cnZ2LtAEzVMZt1uz+PXFLyl3B2dxPSv6USnw0thevN5KbjWf8C+zDEnSVWzz4W1GFQR/AAbeiLM5J+meDQ4uW1xkh1rRqWbhwBlWQiY90ePC6p8RXeGLlJM+jg+7iU48QW6dsn+uVzxyjMjUmu+ZgesszTGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cXrFWDZl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZVpvrRJg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E6YwJr360359
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 08:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EgDwSfoHlPR4BzQVDlImDB1JZ9TsM+Jv3+MUyy8Okhw=; b=cXrFWDZl0GE52Ums
	pu0rRBT3oUVWHLSPFGzKJFr83JroblC1GNQ7jFCb/5QVqzEV8vIIcJT8avkI5p6Z
	nBzgLyDyRJM0Fd3Q516AHU4zsHc4J/hujgRvCEgfR+NUpdk4Ai/tUxZKOeDLz1NE
	5a2cl3tnNjoNCWa+Re1ivILdZcZC7fagcniSyBRwkCtS9qXSDk3S12EYAcwQpTrM
	6BO4nOKLtY++cyC202z0FXncQqq52cTWa19LZ7clYnnGw14EDgqsQhXg9pn+ADaW
	+iDuxKPlPMNA8EdMlN6iI5Qm8kVLh+CD+NuuRE2Jjby3MIMw64L8Jdrr4n2/SKsB
	21LpNg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e513g9wmt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 08:48:58 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-13312be8a31so4389930c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778748538; x=1779353338; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EgDwSfoHlPR4BzQVDlImDB1JZ9TsM+Jv3+MUyy8Okhw=;
        b=ZVpvrRJgc5U8UlJ8OsH0EZQhWpHQbi2d33VlX/09t9YMg5+yTVolWVG4ANkjR4yku3
         NsRiTYN1gP6ezwyktcjSGA9n+NzVojDUyoar2vQ8Y/+7o4s66q+ZtmFijxZtX4GztQss
         nUhgVLn80bHu7x/D5SL8wHvCbbu1396HUmwBKg4iB8aKim6O6V4bgV95fzjp3zGm19FE
         wGxKEAwnDgSRAt4LUx91dNqWcDjg3CyMlBOZh4KYdC2RkrqEj6RuouBvyulSiGkqOZPJ
         FbpcIyY6BX5iwiCIdDMreM3ZSTS+cPlxIEGaeAxH0/gDrPLQSKFRxzAfQGj+hFH1oYn7
         Ks+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778748538; x=1779353338;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgDwSfoHlPR4BzQVDlImDB1JZ9TsM+Jv3+MUyy8Okhw=;
        b=STdYAg50w0gfciixocX+3QVV/ZITUyib/zewWdy+5j41uf3xksWhc5L8gmVGhef+qv
         APJld5FhYP6Xe5xJzQPMLpst6uwa2TyGkHdEvx7zQyzG0xK6lZNEiP4xAnMd1s/RUxaX
         Vt+G4vGzK6LA6kcaNx/jVR6y8cwY67m3FWvy53kEafB/oaLp+Hf6bGBVod0K5xqMLDLa
         S+3aAGMNsjRNQuD+r7+SuC+LL0/Lv+5/ZwBve5p4hFXQI5IZY33gB23W84UXU8EbpEVX
         na7Zm5aMTZNgwtwLBNBDvsxgVXmTuEus5Fk6WK+Btu/0ChbqYdNaaN5sNSlkPUSEG2/z
         L6Ow==
X-Forwarded-Encrypted: i=1; AFNElJ8SlYjNa5thYu3k6qxkp+hbLoBgRc+Mhu9qgS4wWY32et/Ye8Y4BhiRYhYUbvzBpXr7tJyxoy58RBfgHiJU9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YykGa7pI/+nxEkx2XVAv+28vyK6JdKBPxmjvDbQT2vwzsQ5hxed
	3sEsAj/IvqPsRvEQT86HuYAe8zn4cSOnlYGD1V8VS/aDcqJPHZVFgph/mTsBhjZpyMmCRu02y34
	J2Y4RAvdwb6cYVgi80IHuE+HvS7k1cqqUbh1gl8bx8RquN3wjfIL6s+XCl3dM0a9ccITPlQ==
X-Gm-Gg: Acq92OHLcxCzR6ShD9PtAVb5EsgoQ5EgriKOnleOmp9rThYVNqtFgalZAteIrdJfoQe
	rokrYuzB036ahih06f5B75cd0iV/LWWm2qRjHal+2IGeHV+dy7VYI5aJIKu+uPpE4x8OaTl2h82
	zPFYCF1ixOhAxpo914ztIx+pGjBgjuKDylXUGTC5b9aoqBK7iRyLcNnr76oFR5PxE+cV12428J5
	fF1K3OQY1h2s5s+mpjpkMtB5TzMocBDur3TPTcnB9oAbOP5K2qibHHjnqDcsIVbU6YujrOQnf1x
	8f79zm4KundVpSBxgoSDdB/T6mj/DQeHyCrBKCVohW8Y7YIHB9+eljZxAH1AQi7FvwHWj7z+RLg
	m6ehCfIhTjsv1f1F0KNsLuZOULYoBZvY3D4zQ1PHZc5uwtOJzx3ORijmOmg0=
X-Received: by 2002:a05:7022:f516:b0:134:7497:2148 with SMTP id a92af1059eb24-13474972255mr2575893c88.28.1778748537890;
        Thu, 14 May 2026 01:48:57 -0700 (PDT)
X-Received: by 2002:a05:7022:f516:b0:134:7497:2148 with SMTP id a92af1059eb24-13474972255mr2575877c88.28.1778748537392;
        Thu, 14 May 2026 01:48:57 -0700 (PDT)
Received: from [127.0.1.1] (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cb5b3c20sm3658567c88.0.2026.05.14.01.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:48:57 -0700 (PDT)
Message-ID: <6a058c79.4ede001e.7a438.4eff@mx.google.com>
Date: Thu, 14 May 2026 01:48:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
To: Amith A <amith.a@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH ath-next v2 0/2] wifi: ath12k: Add support for handling incumbent signal interference in 6 GHz
In-Reply-To: <20260511040242.1351792-1-amith.a@oss.qualcomm.com>
References: <20260511040242.1351792-1-amith.a@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA4NSBTYWx0ZWRfX0RySNOAew5Pa
 lx65OCOA6NhqSEV3V05ltzZepr8TtjTpUfBtM7kyAY2R8DJyVTHJJRcRRpJGtEIQg5N+K7QMkzc
 Wu++8ZW+FfFoYIopz89zL4RkqdClKwqK42THWZIawWDk3fsYeUoJTIGUDFK1g5AoRkAyWI7knT/
 9DTmkz5RM+pE/MrpqyrjzivsbN25wxRseIxhkEBQNkFWNMVdpCjIEC+m9oOoUi/SDrhYCgy3Acd
 uBoksvb/125mJIFlW1O4NCY0Cl1uWW4UjFvVXFZKieKLjeeDoX9lpDqDTv8QNxpU9puqZDvTVjk
 Uk82DzaWbOXhaWICL/JythdoWEytEafFCQ4X3+UlDa7eNjwm84tlStK6CkLe0ehkE3YLYvSldkt
 SqGqcy+7qPH6kGguFk9WG5qNmuBKhEiiVxO2jUOY+N4mqO9SR2ksM3a4Kyl6+3m3ztQGLw16OEy
 vQf+F/8jhHOvay86RwQ==
X-Proofpoint-ORIG-GUID: gUXxr1shObstD9ajNewdqG43YljOOFzy
X-Authority-Analysis: v=2.4 cv=Iba3n2qa c=1 sm=1 tr=0 ts=6a058c7a cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=8NM31TEM1mEMm4nbO4kA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: gUXxr1shObstD9ajNewdqG43YljOOFzy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140085
X-Rspamd-Queue-Id: A719953F789
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36415-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,mx.google.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

T24gTW9uLCAxMSBNYXkgMjAyNiAwOTozMjo0MCArMDUzMCwgQW1pdGggQSB3cm90ZToKPiBUaGlz
IHBhdGNoIHNlcmllcyBhZGRzIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBoYW5kbGluZyBvZiBpbnRl
cmZlcmVuY2VzCj4gZHVlIHRvIGluY3VtYmVudCBzaWduYWxzIGluIDYgR0h6IGNoYW5uZWxzLiBX
aGVuIGFuIGludGVyZmVyZW5jZSBpcwo+IGRldGVjdGVkLCB0aGUgZmlybXdhcmUgaW5kaWNhdGVz
IGl0IHRvIHRoZSBob3N0IHVzaW5nIHRoZQo+IFdNSV9EQ1NfSU5URVJGRVJFTkNFX0VWRU5ULgo+
IAo+IFRoZSBkcml2ZXIgaXMgZXhwZWN0ZWQgdG8gcGFyc2UgdGhlIG5ldyBXTUkgZXZlbnQgdG8g
cmV0cmlldmUgdGhlCj4gaW50ZXJmZXJlbmNlIGluZm9ybWF0aW9uLCB2YWxpZGF0ZSB0aGUgaW50
ZXJmZXJlbmNlIGRldGVjdGVkIGNoYW5uZWwgYW5kCj4gYml0bWFwLCBhbmQgaW5kaWNhdGUgdGhl
IGludGVyZmVyZW5jZSB0byBtYWM4MDIxMSwgd2hpY2ggdGhlbiBub3RpZmllcwo+IHRoaXMgaW50
ZXJmZXJlbmNlIHRvIHRoZSB1c2Vyc3BhY2UuCj4gLS0tCj4gQ2hhbmdlcyBpbiB2MjoKPiAgICAg
LSBBZGRlZCBhbiBleHBsaWNpdCBsZW4gY2hlY2sgaW4gc3ViLVRMViBwYXJzZXIgYmVmb3JlIGFj
Y2Vzc2luZyBpbmZvLgo+IC0tLQo+IEFpc2h3YXJ5YSBSICgyKToKPiAgIHdpZmk6IGF0aDEyazog
QWRkIHN1cHBvcnQgZm9yIGhhbmRsaW5nIGluY3VtYmVudCBzaWduYWwgaW50ZXJmZXJlbmNlCj4g
ICAgIGluIDYgR0h6Cj4gICB3aWZpOiBhdGgxMms6IEFkZCBkZWJ1Z2ZzIHN1cHBvcnQgdG8gc2lt
dWxhdGUgaW5jdW1iZW50IHNpZ25hbAo+ICAgICBpbnRlcmZlcmVuY2UKPiAKPiAgZHJpdmVycy9u
ZXQvd2lyZWxlc3MvYXRoL2F0aDEyay9jb3JlLmggICAgfCAgIDggKwo+ICBkcml2ZXJzL25ldC93
aXJlbGVzcy9hdGgvYXRoMTJrL2RlYnVnZnMuYyB8ICA0NiArKysKPiAgZHJpdmVycy9uZXQvd2ly
ZWxlc3MvYXRoL2F0aDEyay9tYWMuYyAgICAgfCAgNDYgKysrCj4gIGRyaXZlcnMvbmV0L3dpcmVs
ZXNzL2F0aC9hdGgxMmsvd21pLmMgICAgIHwgNDI1ICsrKysrKysrKysrKysrKysrKysrKysKPiAg
ZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEyay93bWkuaCAgICAgfCAgNzIgKysrLQo+ICA1
IGZpbGVzIGNoYW5nZWQsIDU5NiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gCj4g
YmFzZS1jb21taXQ6IGUxMmQyZDM5ODNhY2IxNTBmZDk4N2QxOWVjNmEyYTUzMGRhMTEwZGYKClJl
dmlld2VkLWJ5OiBCYW9jaGVuIFFpYW5nIDxiYW9jaGVuLnFpYW5nQG9zcy5xdWFsY29tbS5jb20+
Cgo+IC0tIAo+IDIuMzQuMQ==

