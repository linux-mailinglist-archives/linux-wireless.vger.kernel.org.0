Return-Path: <linux-wireless+bounces-19301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D128A3FF45
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 20:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2484256EA
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 19:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC19D2512C9;
	Fri, 21 Feb 2025 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Bilcq9IE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F21FE478
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164613; cv=none; b=ADqezUw6sZEw8wQjuku0Lj0Se0amfhhjSkw9Buu3LCrIfFNAXv8SgeC6zyBJliZAbcvTFFXfKsEuPanQAx+Vc94ZEDbJC4AKOb1B7/4d/JJQ4MIqpMRPav8avx2UkM6H0K245JU9RcyTmhCjM1OU/tvyVHDWN/Ko0S3irsTl750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164613; c=relaxed/simple;
	bh=7FI96NB56x8g5ULl28oXb+zIk7PEsGKwNCZ8Jpn8hzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eYkHa3W9fA6lkoPBHRFih8aB7+mEscQfnv586FzV899QWvUHWVgPdMFiSBQte5BRzWw/XKv98iEq9xxIs8fA71lNKIDw7ND3exQH8WPvwlW+Yfw09fwopOxXZOGWoQ521hGjiVrl2RuSd4mxWF6GmdIruB6YLeYcYKNlp+lpa5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Bilcq9IE; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=p3DNeByxz36nxI9Sc2NbQ1+CjktRgWe76wtYGzfZ5aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=Bilcq9IELzeRgTYqAAcDnu0f2zE0EAmJcOqWhgiNP/FpPoC4v9vmrubo0qOSOclij
	 9S2GjaQKn6xO3IJ+hs5BedPTS/ZYCqYOP/6ghdAyZdsUUtOUMwNHB1RPkdKLEMpDLb
	 PJa0Ow4IhnNO1SPJObT3nPrFcaRga3Gch0wRJJp8XqVyoUiqyekFeW/EPVY1NFSLO8
	 Z6KMH3wA3mF4RhwXfM2fX8dimnhKk+v74yKEeQbf1GxTOx5rsmjJbiLxqb1/eZoaJO
	 tv9ict3Bs2dIwZOBkRyDn2Sxn1/Z3kH9Tc6Dyw0K+7j/2eDypniLvhlM+/cBVftgHX
	 GS/d+bT5U+aCQ==
Received: from [172.31.0.20] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 4859368023E;
	Fri, 21 Feb 2025 19:03:28 +0000 (UTC)
Message-ID: <035d9edc-9290-49ac-b875-749e709074d4@icloud.com>
Date: Fri, 21 Feb 2025 11:01:57 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: /proc/net/wireless has gone missing in 6.13
To: "Artem S. Tashkinov" <aros@gmx.com>, linux-wireless@vger.kernel.org
References: <ea0541a6-9d4f-4d1c-8b4b-4bb29eb84639@gmx.com>
Content-Language: en-US
From: Alex Gavin <a_gavin@icloud.com>
In-Reply-To: <ea0541a6-9d4f-4d1c-8b4b-4bb29eb84639@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gU7wIrNnePemKP9C-30Q76jDxnhTY74Y
X-Proofpoint-GUID: gU7wIrNnePemKP9C-30Q76jDxnhTY74Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 clxscore=1011 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502210131

On 2025-02-21 9:10 a.m., Artem S. Tashkinov wrote:
> Hello,
> 
> Multiple people report[1] that /proc/net/wireless has gone missing in 6.13.
> 
> Many utilities/applications depend on this file presence.
> 
> Please restore it as the kernel mustn't break userspace [interfaces].
> 
> 
> 1. https://bugzilla.redhat.com/show_bug.cgi?id=2334171
> 
> 
> Regards,
> Artem
> 

Support for /proc/net/wireless is still present in the kernel. However, in the GitHub issue
referenced by the bug report you linked, user 'clnhub' noted that Fedora has removed wireless
extensions (wext) support from their 6.12+ kernel builds [1].

You can still build it into the kernel by enabling 'WIRELESS_PROC' in your configuration.

[1] https://github.com/clnhub/rtl8192eu-linux/issues/111#issuecomment-2562629866

