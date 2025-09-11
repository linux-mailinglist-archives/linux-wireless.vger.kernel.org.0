Return-Path: <linux-wireless+bounces-27237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F15B5291A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 08:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6721882A60
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 06:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7284B238142;
	Thu, 11 Sep 2025 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lo2+8zD2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7486259CA3
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572685; cv=none; b=JhXLnhj1dlePy/enuc+g7gQrcIL4qqbTwZuvyOBoQQeL9ilvhFnFFhs4qBSaAFRW9gMqpieTYsr5G88sg3qWMHfNCZDkEEkQvKEQT8qXkkc+rvSeb3RPtqFQ1kpC44DSJxvserG3lVP+BTuZPFdVhESoia3z//clhCTObLW3kz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572685; c=relaxed/simple;
	bh=+Ci7qdgBgyJe2UrIMic/tfFkGEGSNKG+ubpPEQWyZHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUGLXemMR0AA+7z7cgKwovQ/QTPkEARgR2zCs8E+VxTY7QLoNnlUiwCQiaMSZQKWWu9S2O+KHFpYHeU1wWt7Y9iPQ0oNY5W6B8IWny68HcLM7PPCZtjkOLoojFYpIxQBloyDJcgUZoWhiUuSD66vHIfDODEM5alSrPV1tHl4pjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lo2+8zD2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IgGq002482
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 06:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Ci7qdgBgyJe2UrIMic/tfFkGEGSNKG+ubpPEQWyZHM=; b=lo2+8zD2VX/KtPDI
	3/TwZPbw/yo8wLNKaUSjlZ10dhFJU0ZPILb5kIaQKg5/pxJS6TMiH+0T2sgyy03f
	LxMi/q8yoUJYYh2rKCLN6MEEfm5nIcdQMRRPUSHtaobN2B19qy+Tfm/URZGM4X3r
	9eP6Uburb/gYpkxMz4l37lBZdCKJDQksSRfptoUkIuWy+iiZ4wvuajlFRfP5Y+7O
	d+JQYv/gwthORY292jpMOG6yerVrYlb74dYirMVdXWghh3R7nyY0BkpG2pVkOsJ4
	cF5ZSU1F4A/93y9L00vDp+OiP+16HrNn7BrxW4P/GJnnrSEIy/6zfq93d1vVc8h4
	X5Dyjw==
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bwsepp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Sep 2025 06:38:03 +0000 (GMT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-40babea9468so5127705ab.2
        for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 23:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757572682; x=1758177482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ci7qdgBgyJe2UrIMic/tfFkGEGSNKG+ubpPEQWyZHM=;
        b=SGSlKrEUbttV5pbXBXMAA1vf0BVxMiP1IVdkLAlxnKYnqpGRqyZmDVW8KzUpZ5pfG0
         75nXvix9LcL2cTnv/lFaJhTw9Ns4XhGFWpXAA3RmyY1beIrmPMT5YhOBZmw/SnDhqp/s
         e2KXQgvNocX/aRiF/PTQ5fJqjVF1j1McLkTDzHI1bPPaxtSmkRd4PTOyktkk+RqYnaYt
         5W/vCXVfHF3uTyexpQ3p0C+NTndDdIkX5iAsdBhkX40aeMAPRf0JAvgoCNs5Z+wlLc5B
         Fzt8aTUWo0CHTe4vZguPcrW+sDQ9RBurx199vNBWEeys531ekCDmo9HWF2Q/8DvJYe6z
         Zljw==
X-Gm-Message-State: AOJu0YySA1FZslFk0wCSWnr0zbD6r4f7+5I87XQ9tH5Llx5oEppin0zq
	si7RfStLQgzmJD6xVzwsQi8KHk4xGw5XnVw3rVjzndhnXUDWGY2O8V1Ip2lbMw8QKfMnLS4zWCN
	QOh8bPwzLD+CyUyhD19pIinyXhJfSeRDcTKhRf9VER2vd/n6/YkFZjTRD1EQu8chC+G/jPZ9+uw
	MdprWF5XD47ey6NaN5gCdchlp6a4lGEgbYRYDBB3ntTAEAdNfT7zM7bME=
X-Gm-Gg: ASbGnct+bP1MBWdbTUZF4UOl6Po8/R1+118JnT0Chq77qR/1zPTNS/NCgxcZB4whVLK
	LA/9VM++YYOxZzBWsoXB/gguLja7AYMXsG8CExM74vbykLONnoYDYoLjb17vZAoq7XRtVXY6Krh
	wWHzFMWWU6m2yNOn11wD3NG9A=
X-Received: by 2002:a05:6e02:168e:b0:41e:dc1e:614b with SMTP id e9e14a558f8ab-41edc1e6343mr1944185ab.32.1757572681963;
        Wed, 10 Sep 2025 23:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNQMuDJYbAL6ndhm9/R6Y/BaEQWZJLcWR2UZFy83OOZ43MdUyMwAG1L9l9rOEit0F8e7FJhTXFSy5+Y9gPgSw=
X-Received: by 2002:a05:6e02:168e:b0:41e:dc1e:614b with SMTP id
 e9e14a558f8ab-41edc1e6343mr1944015ab.32.1757572681580; Wed, 10 Sep 2025
 23:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905124800.1448493-1-nithyanantham.paramasivam@oss.qualcomm.com>
 <a83d883d0f251c08de7dfe7f2b3e7ab890a9b1df.camel@sipsolutions.net>
In-Reply-To: <a83d883d0f251c08de7dfe7f2b3e7ab890a9b1df.camel@sipsolutions.net>
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 12:07:49 +0530
X-Gm-Features: Ac12FXy2GrT9fRzERQC9dkcIjCpesCHOqWl2h2s18c-1tkRkF5-LzmEB2VFrFnQ
Message-ID: <CAD1Z1JJqgVdXHiggeBuQvqwOSHzrzuYZRw3khey9v3oy+xN5pw@mail.gmail.com>
Subject: Re: [PATCH wireless] wifi: cfg80211: Fix "no buffer space available"
 error in nl80211_get_station() for MLO
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: RKhUyilO8WQgjvk7AFXkzEcbS97qRaH8
X-Proofpoint-GUID: RKhUyilO8WQgjvk7AFXkzEcbS97qRaH8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX51XzwdXWgmbv
 UpWxkarOXeTbR4nC5anpq9zZYgs0TozSLAi72GsIzIrks3XbZsa43t5nNBR9kjUyYfsJlPIf07B
 a8Az7MX7ms90/mV3FbyHns6k/y2CdZGclIzHC8Lf/wTKBnlyP9Zg+XzRHBEimd5YwArDfWncWoF
 ThLD1dfKRf50fEbbIuxrDm+96crQYBbQVUa9F09nmzcrbxQavQ7bf0X2HEh7v9hZZqAWKbmvJYM
 vevATgJ+WCXR76RwgrkJydZTbC85vyMQwQXXTlPxrOjVOsdnleKJPr+i0PcgHn0FKLvzbzGHE8M
 bNqkz7mpIEElmLnqFPptTHq0TktnvkKQVzw2uXnnbVu/kV+AOQCPFPJyMrTk7eULv4GbAx++QuW
 hIjywmjt
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68c26e4b cx=c_pps
 a=5fI0PjkolUL5rJELGcJ+0g==:117 a=kD4sTvn9sZURAWMP:21 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=stkexhm8AAAA:8 a=1P4ObLHyvds7FFSy6CMA:9 a=QEXdDO2ut3YA:10
 a=HaQ4K6lYObfyUnnIi04v:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

Hi Johannes,

I agree with your thoughts.

From what I observed, a large sk_buff around 32 KB is allocated and
passed to nl80211_dump_station(). However, this buffer size isn=E2=80=99t
sufficient to accommodate all 16 links(max) when full station
statistics are included.

I also agree that splitting the dump per link within a station is a
good approach. I=E2=80=99ll explore this further and come back.

Thanks again for the feedback.

Best regards,
Nithy



On Wed, Sep 10, 2025 at 2:04=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Fri, 2025-09-05 at 18:18 +0530, Nithyanantham Paramasivam wrote:
> > Currently, nl80211_get_station() allocates a fixed buffer size using
> > NLMSG_DEFAULT_SIZE. In multi-link scenarios - particularly when the
> > number of links exceeds two - this buffer size is often insufficient
> > to accommodate complete station statistics, resulting in "no buffer
> > space available" errors.
> >
> > To address this, modify nl80211_get_station() to return only
> > accumulated station statistics and exclude per link stats.
> >
> > Pass a new flag (link_stats) to nl80211_send_station() to control
> > the inclusion of per link statistics. This allows retaining
> > detailed output with per link data in dump commands, while
> > excluding it from other commands where it is not needed.
>
> I guess I'll apply the patch for now since it makes things _better_, but
> I'm really not convinced that it's actually sufficient, and I'm very
> tempted to throw in another patch to make it always false for 6.17.
> Convince me not to? I'll reason below:
>
> It seems to me that with many links, even for dump you could easily need
> more space than the size available for a single dump message just like
> with get, since there's no fundamental difference between the two. So it
> seems to me that not only should it be opt-in from userspace to retrieve
> the data during dump, but also there should be the ability to split the
> dump not only on a per-STA basis but also per-link within the STA, which
> requires some logic adjustments on both sides (hence the opt-in.)
>
> Especially if we start seeing more links and/or more data for each link,
> this will otherwise become an issue even in dumps.
>
> johannes

