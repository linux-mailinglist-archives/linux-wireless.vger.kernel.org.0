Return-Path: <linux-wireless+bounces-27720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DAFBAAF8E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 04:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE55D17873D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 02:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BE41FCCF8;
	Tue, 30 Sep 2025 02:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h755Hk+s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F64786352
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 02:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759198671; cv=none; b=S0tj0VCyxKWk+yoEeUqaIa03y2hUOJYo5nvXKxAVyaeKZCta0qVmfARV4MW4eAYZIcpK06VwCBuOB5Kpn9/gB7sDc3yJVlovCyY2/ERhkgkvt22zX4vob5jkTA5cdycqjsjz834+AGvIPsTWOlhg/gCYB2mSVinAy/+cEbE4atE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759198671; c=relaxed/simple;
	bh=u37XjavqL48j4PspPTFfiUs4b1prvjvWY/vINUMofoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXGcYyEc4CEBeNhYXvVKmwauVT7n8cMPWB8Z6+Z5r5CVBP7iWDhBfbivqLxnSaYBM4+9Iw775uIrLKRzsU8NpNdy3fn5ePCEBfGAMsHJQSAm/uCZx86pO4frvQdIa5gSxkIM8+GWPld/1dtqcYkq6DC12EdBqQT2tNG6hw3Bp+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h755Hk+s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TKHuMO014157
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 02:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7hz1f+ctCOdSlQLCHYJ0Hn1Xi6hiM56h1h0iU9p+8gY=; b=h755Hk+sWaYbZulx
	Do1YHY2zJlsOcKa6/C3oEkdXCsowlx4dfvWbzd0dRQ2jxdajHDsPR2ERZag9a8Ga
	eBNCieH8VvSuWfM0beEhgArNZKJKkZduY1kjAliBMauDIRYuUDOGShYbvZzSug/J
	ZPIuA+sTivEyoMVNASBK1SHnWKd0RwAFFtLa/RrownSXJBMWidcbuGM9eFT/DQYX
	6hiE8jx1Ue8+iE7SyLHBC3rrnSESNKXfspL+lzp9vfjnm2zAkHM+LPNDFeLbOY1W
	D4iC0nW8vkom1nMzBoAM+RQL+WFjHeuAO5vCKyGgX9nt5RZZX56GRbE/5SShyfXT
	8D8iXQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vqyb6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 02:17:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eb2b284e4so8491624a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 19:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759198668; x=1759803468;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hz1f+ctCOdSlQLCHYJ0Hn1Xi6hiM56h1h0iU9p+8gY=;
        b=wfMEx4ZxNWuoH+v6QDuyyvbvztzC4gDtffpVEawqh/66a/lltlVWVA5KTW3dHw4QPm
         mHoNJgomu9e/lLwNYOSA86JzLrxVxwY0FBClLGMARw/YsfTrEq9dPxetcfKWH8waygjR
         G0Ajxivv7c7num3qJNk11GkryG78t6G2vKNCqKq+zfm+B+Cqjdq+YoJA5P6cIfGzoKww
         UKa31aT8lOPD4SSLXhyLDYOTJiWG//Usb00oSVSghvts7ab3iUOsjeMhrzKgORBpoDP4
         tTYhmWVccyOKDYu2jt2PktcNNsLhfhwBDafGhz0nrmMM5y24e+Hr6AOIXeBjRPj7jNhi
         l+fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy09CdAxY1MP/YcSnJp/E+OuOiL5zABFMe1dYj9qMOQ6KUXElTWcX+Y5PQuD9J1/trCzpV/8plQ14R3536TA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx/Lts1fYJ1UbaK5zu1l4AS+mdDZdpSCWYVKQLTzzQPS97GCf3
	7p9lIgTMM+SqkTb7TCs3lYPosOjGeB/0F64JwJ7pHnQ8kEXU/WOY5/0AJPwEPIeR+Vd0uN5SUPd
	+PZf3r+R9Xz0q7a5BJNcHVvIH7UCo4oXV/CAMc0O30Sd6NE2KCjxpReZ4Jc/FIxzN09Vxkw==
X-Gm-Gg: ASbGncv6HMhn0UrnLcHwETHPw5tLYNR72XbxAqFhNTnp4NJOxBST0guYHiF4nX/70fe
	JMmp6RL7W/LnXfacqDhHbaz4MvC2AIqCGoON6+acADh3OoF3mR9zIaRd41dPBRnD6hu1s4EilEc
	S60bS27yyHj+oyt/Zrk5B6yVQEddrBa/HCS7UeuBKqVgGCeg4Qh6iAAOmfbfA3DrBITI0ie3u/o
	9JeOkqCYwZaRUIb21x72F5h1d/1qaodtylvRH20ir6MPWrsb9l4YxGrnM2gXyFysNpgPnSoCrGW
	jw4XGI1Xxub2hFJpJDghAW+/g6wCBo8R6kKorLjYPBM8bw0XkKYNnpcmVVjPEsLcerHcx+KISYu
	DFcs8zt04ZzyTPsfrsCiRDeLOSWmg35piVZaiTZ25qA8=
X-Received: by 2002:a17:90b:17cf:b0:338:26e3:ffb6 with SMTP id 98e67ed59e1d1-33826e40c1bmr6342135a91.26.1759198667776;
        Mon, 29 Sep 2025 19:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERVbkhp90h5tu5qmYaSGCuwLFew5siZS6pQayKuLPLoYMEzOkFjAetMuuaX50AkGwV+Nzzag==
X-Received: by 2002:a17:90b:17cf:b0:338:26e3:ffb6 with SMTP id 98e67ed59e1d1-33826e40c1bmr6342113a91.26.1759198667227;
        Mon, 29 Sep 2025 19:17:47 -0700 (PDT)
Received: from [10.133.33.193] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33838707fb4sm2727780a91.8.2025.09.29.19.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 19:17:46 -0700 (PDT)
Message-ID: <83de6105-ef4c-48dc-8960-430893ae253e@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 10:17:41 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: Add missing platform IDs for quirk table
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: jjohnson@kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20250929192146.1789648-1-mpearson-lenovo@squebb.ca>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250929192146.1789648-1-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vlYYr7TgZttEasklFBVQZLr_lL2v-JvV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX9TXjs9sVSsZY
 JHSmJG/yp8e1dAiDDoszuJiHzIXZxfZK1+gyu76mrcI9tJ+lcCZWzZ5xEUlq0ALSPo3HxmuYFNJ
 rINUlpqAFk1dlobpCHVnwiWXoNtX3QOb4sUCewRY5zF82xJMgC+XjYejO5iQli4so8UNK70IO1k
 G+yc61NHSzOV+Y8M+HJBacgSQb0MIaxCOYit4JCSIi/sq+zs2PyDqiVH6z8gBINaXTFTMyDkE11
 9Jfs5KJp/pHuxMigzevkvTUuzYMxUa3XYTIf+5hsOrZfNNa0LiZuo9su0aPqiNvbRf1X+OM2taz
 d35IYinCLBewkgKOjiVVZI48yqb0SsyMO1Tl5OC6cW7AueSV3zCE4Q4C7PGm4By0sukVvApznqq
 fMd6xG4sK5MfcGHEicRqQBhBh7fdYg==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68db3dcc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=XVxARQIAAAAA:8
 a=EUspDBNiAAAA:8 a=ZOm3kqi2FSFO-1B7WpkA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=p77dMD-AzHemhwI1qD6W:22
X-Proofpoint-ORIG-GUID: vlYYr7TgZttEasklFBVQZLr_lL2v-JvV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017



On 9/30/2025 3:21 AM, Mark Pearson wrote:
> Lenovo platforms can come with one of two different IDs.
> The pm_quirk table was missing the second ID for each platform.
> 
> Add missing ID and some extra platform identification comments.
> Reported on https://bugzilla.kernel.org/show_bug.cgi?id=219196
> 
> Tested-on: P14s G4 AMD.

Leave a blank line as 'Tested-on:' is not an official tag

> Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machine model")

Better to move the bugzilla link here and reword as below?

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219196

> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
> Changes in v2:
>  - Correct typo for T14s G4 AMD to use correct ID. Sorry!
>  - Added in Fixes and Tested-on tags correctly.
> 
>  drivers/net/wireless/ath/ath11k/core.c | 54 +++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index d49353b6b2e7..47522fa186a1 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -912,42 +912,84 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  static const struct dmi_system_id ath11k_pm_quirk_table[] = {
>  	{
>  		.driver_data = (void *)ATH11K_PM_WOW,
> -		.matches = {
> +		.matches = { /* X13 G4 AMD #1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21J3"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* X13 G4 AMD #2 */
>  			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "21J4"),
>  		},
>  	},
>  	{
>  		.driver_data = (void *)ATH11K_PM_WOW,
> -		.matches = {
> +		.matches = { /* T14 G4 AMD #1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21K3"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* T14 G4 AMD #2 */
>  			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "21K4"),
>  		},
>  	},
>  	{
>  		.driver_data = (void *)ATH11K_PM_WOW,
> -		.matches = {
> +		.matches = { /* P14s G4 AMD #1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21K5"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* P14s G4 AMD #2 */
>  			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "21K6"),
>  		},
>  	},
>  	{
>  		.driver_data = (void *)ATH11K_PM_WOW,
> -		.matches = {
> +		.matches = { /* T16 G2 AMD #1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21K7"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* T16 G2 AMD #2 */
>  			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "21K8"),
>  		},
>  	},
>  	{
>  		.driver_data = (void *)ATH11K_PM_WOW,
> -		.matches = {
> +		.matches = { /*P16s G2 AMD #1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21K9"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /*P16s G2 AMD #2 */
>  			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "21KA"),
>  		},
>  	},
>  	{
>  		.driver_data = (void *)ATH11K_PM_WOW,
> -		.matches = {
> +		.matches = { /*T14s G4 AMD #1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21F8"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /*T14s G4 AMD #2 */
>  			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "21F9"),
>  		},

assuming Jeff can resolve above nits ...

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

