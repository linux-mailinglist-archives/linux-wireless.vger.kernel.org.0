Return-Path: <linux-wireless+bounces-26937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA93B4060A
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 16:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7FF3BB678
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 14:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06C51A08A4;
	Tue,  2 Sep 2025 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VRxMtpHD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3E32882DC
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821628; cv=none; b=IaUBHGEMIddwZG7RJDSCgdMxqyRafJTDfS67R0LJ+TMmxsZJMfZ797dkuu/Gwy45GVjUrQ1A51MFetaYWyC+6IURtWttVAXwueCXTmWASdd1unD5dd5a6JhZ9S/dr+v4fuWwbkgK2QZWQRQ8sQfyFJRSs0hGiu2OCSZNUo1AP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821628; c=relaxed/simple;
	bh=csusaucqTmzk17SeeOJaLqL2TcfNjobPHirLjmjAGww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKlU+/Ye2EwJJ0bX40el+baTfQCPrxCDjuv9ZlefSkBdHrX2b0gQ8MjdYo71APJCqwwtT5674rc2e3r9TBQEPOPnUse4Tvo8vkp6Y7ALVzgieL5wdB5Gnnd7shdsz3im75yW89eEC67vJhxQdWfhlPuB4nX1uLNt2Fpc9/s/BDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VRxMtpHD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582AlIXt012350
	for <linux-wireless@vger.kernel.org>; Tue, 2 Sep 2025 14:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	csusaucqTmzk17SeeOJaLqL2TcfNjobPHirLjmjAGww=; b=VRxMtpHDll9fc9A3
	ta02jSVe4EMmN39ro05+m01qqFhoHEoadcUMPOIuElI9WVmdrxf/KO/31cR2DibG
	A2cA1UfpKvH8HnS0wDkjiMnonbOnrfBQpHMsGEieODCCgQJUwOf1uZ7CKw5PXTGk
	+kUPE3H8mRuLTI3/e6bhgB5Wu8RRHbN11NCteGmUUcgvNBHZz4bvhUlGHMtQ5kvr
	xRPGt/OIK74bC86UeiYIfjYjo+xFnPW0kpDrgx0FUdepgY+llQC8qDK6pAfYA5a/
	2HwRwbPuMWh5MhPGlzojyFm8pog00Ii+XT8yKCkYLVL60D1mXbozyR/ubHZHEFH9
	E9TGIA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2ffx18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 02 Sep 2025 14:00:26 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7f88956825aso1065403385a.3
        for <linux-wireless@vger.kernel.org>; Tue, 02 Sep 2025 07:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821625; x=1757426425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csusaucqTmzk17SeeOJaLqL2TcfNjobPHirLjmjAGww=;
        b=FVT9ksF60y7haxb4n+Wt2TK8I6syEIvIDD1okK8ZBBKSVFSTnQ5FDRyN2yZSoXrKaM
         1c5xn3njlRg5/tOPF9+Y8NNYVzdu3jwrXSbWNU6SCDo8eB5MKVIRgIWhLbQ5HdFlVrAb
         uXnG7eT1T5Aa2NYA0SChEQXshGguUVd5sA569YOpY1soBTLdo4wxxOJ2M2yJXQbca/HU
         7OXkIFvu4xXZi2grBcnkUxgqEUzxrN5EwVEPjKfF1DeKgWgfBdJVYhTchHVAEJccD5Le
         F7qllK4H2qftjI1uyLoix2xbqkjKvB7ChJIG5pF6o0dfHNRD5QpU4SiNx0kC3WTETJc6
         +BFA==
X-Forwarded-Encrypted: i=1; AJvYcCVBFmShI3GrZ1Rq7ocVftdnfqlopOXvRnbkQq9CCxY34v/9U9NQx22MFJbIqmuE2RDYHLjSnEHaKCnxpdWq5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkh9rv4wk4hdUpb9aQjrGdmGio5CZ1kVDzx4SO+ntMLowGokPY
	uK0vYmyGk28XfgMThueK+cUkoB9hsSmPjUEU+vG72D9CKk8azBpBCCmjyX8JomrDBUtCFSqbH43
	JCbQWnXcWEpnJwCZ5hNolI1OVcEDU2Lj4iOzSsbsZVDP5YlqnAJRaEv19jcMPcuHO//8IybabOe
	83n7s9mpinCEXU0S4IzlxP6MRksA2ws8MV0lnYtEW5LmlW
X-Gm-Gg: ASbGncuf4OE3KQrAuvVU7LMelnc+mJ7BXelW4OSmPazfJxXa4cPNp0MvZACYcyUXP2C
	9gP39VHAXP9ydxFnmlAslhrvr+MX7EIZGBzMgQBr7Yt+9XfT4qUbpqVp4pPWBn/ag/eNShf/f58
	2SHVqpKFtFGn4jflGpgY2f+Q==
X-Received: by 2002:a05:620a:bca:b0:7f6:e8c9:2ab9 with SMTP id af79cd13be357-7ff2b4b0029mr1278698285a.39.1756821623256;
        Tue, 02 Sep 2025 07:00:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdWWZMQ6aOZzdLiT+Un0WMDnOkgUs5Qx1fi85wGxKKPJPLxThT/sZyXwCh2//MRN4U8HhD58o5y53D7lFknCk=
X-Received: by 2002:a05:620a:bca:b0:7f6:e8c9:2ab9 with SMTP id
 af79cd13be357-7ff2b4b0029mr1278671285a.39.1756821620917; Tue, 02 Sep 2025
 07:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902080400.635818-1-loic.poulain@oss.qualcomm.com> <87b92cbeb6c672600ab3530513d8aba5f4b0eb63.camel@sipsolutions.net>
In-Reply-To: <87b92cbeb6c672600ab3530513d8aba5f4b0eb63.camel@sipsolutions.net>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 16:00:09 +0200
X-Gm-Features: Ac12FXwzJQUvQoUWUqvMRrIXFykv3yJhrIuOXl3mgQl_CpVei1qt-s1e8nKX650
Message-ID: <CAFEp6-3vgYLFrkmiO2U2HKRFwYY+_UKt0pkLB9i558E5SNNeig@mail.gmail.com>
Subject: Re: [PATCH ath-current] wifi: ath10k: Fix connection after GTK rekeying
To: Johannes Berg <johannes@sipsolutions.net>
Cc: jjohnson@kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, alexey.klimov@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfXxHuGypIwHZPK
 OjuokbG/9yJKqTbjT+pGeSbJqJB8P4TPaGoB7iKG/WrHWa0Loi5fF4wfURNPcQkUwiFbKj7JvRv
 G21gAjM1yHG75wg6ruw/TMGbvNNZH+EvtB/M5dbbDNNL72gzZqLB3ndb61sU4ukxBicJUKeL8aK
 E56wzIkSwm0JzYHiXNOt7+Nl9Pt1EyXK5wAB+vRqwFsaRbbQ4jHcMyrm+V38qY81DHVP7zT5QQC
 FgVskocBgSwVHo5JvPtkEQLlsxFImPc5l/0l2VBeO957DznkvZkXyPQm1lFW+czbqdJEf7ZGrnh
 uchNjZuoVkaO5fNYDBHEqe90RaCstoUI3N924S8p84WAQ5dBtCvT5l4gOkuKWaL2Ex4QZAtodzz
 5UlHBZij
X-Proofpoint-ORIG-GUID: TbZdMbgc5V9gewOLd3W-V8GkxiOeYJku
X-Proofpoint-GUID: TbZdMbgc5V9gewOLd3W-V8GkxiOeYJku
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b6f87a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=stkexhm8AAAA:8 a=rTrHpxIYefey2SYKP94A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

On Tue, Sep 2, 2025 at 10:09=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Tue, 2025-09-02 at 10:04 +0200, Loic Poulain wrote:
> > It appears that not all hardware/firmware implementations support
> > group key deletion correctly, which can lead to connection hangs
> > and deauthentication following GTK rekeying (delete and install).
> >
> > To avoid this issue, instead of attempting to delete the key using
> > the special WMI_CIPHER_NONE value, we now replace the key with an
> > invalid (zeroed) value.
>
> Maybe better use a random value,

Good point!

> and even try to delete it anyway afterwards?

It would still trigger the initial issue this patch addresses.

> If it's all zeroes then an attacker can predict it and might
> be able to inject frames into the system that way?

Indeed, will fix that in v2.

Thanks,
Loic

