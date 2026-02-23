Return-Path: <linux-wireless+bounces-32122-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGLNMzq+nGlSKAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32122-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 21:53:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A0517D3B9
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 21:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B0EF3069D36
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 20:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1E1374739;
	Mon, 23 Feb 2026 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KI79qAKt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RFLNCJB7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684E1272E7C
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879985; cv=pass; b=YoSJ8N3xvc6dhP+pXeN4QPR8Ow7qtFzjEbDi1aoY5LFU6K80qWwj46KPiB3g1K7WpuxNEKq749daMOw66RDZZpSgpG3xI21ehw/Y7+FHhMhoo/iIobav7gsfgl49/Mrv9/3Wa5KRR3IKiTOO8q4rHDRatkmbEfFwC3sWU2Vr+24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879985; c=relaxed/simple;
	bh=3XdzAHjk1UlOAYx8RbivyZFTPqfTi7YonhgB/5mlBs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9QYntdlcJtYZ39CSMPseAZ82ZN93Qwdcoa8qIcj1DjbiAHMvoA8WSjLN/AijU1UEw1ZDTJO6GZRQzMlYq1JMrE6lmelnOjgmTE12C34fDlRCo2Csy/pdHNBQtxxPvxum5NlaPQMDY6oVzdPno5/Samx+XHfLgPBvtNnB+fnAHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KI79qAKt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RFLNCJB7; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NIP10r561295
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 20:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LMZVUbPRlhsPwvvYy5fOPbSt3iZilYmAeRJ1XOI+5wI=; b=KI79qAKtF0Onc3WA
	hPbvyTG8nA/HkXJU5h4TcXDO0eSfLTKMPdLuTJ6apd3sfyBI2MSE7W0N3AOa43Q/
	grHlpf/17Kw7nCWHJfebd997MufX4yeWRcYS++h/tTI6OHXe06K4PrpSXukNgNmS
	PL4xPH3VyxeOwid8S0mnODKPniihvpgCh7JpSt/g8ynGSKwtREk+sTp3/2igHazx
	m+FDDWGWT02Xq0OqyXSC+n+er+uJwbV4XJz0ZjTF8Ri3DEkVB1qvErYPUglgzKnR
	mLB+6TNew/DWkcD6aF6AuecH+BPxSV3uNviJqEtP3Bn30j2RTq9Ksg1KazaDag5q
	XkgCsg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8r9ue4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 20:53:03 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-896f96458f3so134373756d6.1
        for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 12:53:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771879983; cv=none;
        d=google.com; s=arc-20240605;
        b=UpLv7NGGK/smbnla8pdf9aEt0zxxMS0GFDrsbHgpHDySJAgXB+GsVe/yY5QBbsMbz0
         qpmacGSawSDTgzdM00wW5fZZ3z9MlhpbCcUa/WvbQU9E1O0o6kY1lAoUbrfxPcTSUD9P
         gxPk//JqI2HQQBFpVquQv+fZgmRh7ccRVOrWEPXKSyOdBCvlevga6K3CbDDXQ4mpMVWl
         T9w01gPaeumjMoswxOj16DShPt5ckGjnjhbNA53IHpoenw0nWzvGp6JRSx0mGouRmyQb
         AlD9coiEkzmhab36xjL2d/mx+3aq+MnVnTYSlnBwEZsdUw0Gwvr2yeqldW3UIJmoHAQy
         5spQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LMZVUbPRlhsPwvvYy5fOPbSt3iZilYmAeRJ1XOI+5wI=;
        fh=fjJDIydN1TQk73nlkw3D4H/A4m/tHJfe1Hq0S8GNzxE=;
        b=cIKVRzdfTtlmbyI1Sqo5GZEQszJmBOfIIn7K4b6LFCZ6z1Dpx73R42WjQMxAx4Z7VB
         PgMBQDPMyIl00lkapYrjgPQwV2C5yfFm99HzlDzUUiowXF53gO2Q9A7aO1w1fiT2RvW6
         HGsiYVogx7VIM/LzX6+UoEP2PEFYg/Kw/2WKHlH1Y6kLh2iwWeQJajrJZUf7Ylb7rlNq
         n5D7fX6WUwD5X3phf0GMnTMPJzrGle73fKD2FcMT0leNCzL63uOQa2HdxlAY9j4kZ/jC
         arQEj3G6WnFBclDfWBPKQaQrOrpXzesgetUukis/FhbFLQ7SO6xbKa2Jl8Z5jPrKj0FZ
         V/HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771879983; x=1772484783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMZVUbPRlhsPwvvYy5fOPbSt3iZilYmAeRJ1XOI+5wI=;
        b=RFLNCJB73UW/iY1NBwuK8nLS/JMxjVVNx7dhL0j2qt5/eLv0Zrv/pIC6yXVXT1VsWU
         sVfWyfVGSv1y9ZCYADZmemhahPI9NQeIBcYsgrt5XeHAkwkyLJaGssQZGHZRS6/c6AfZ
         +BKYKLx9j8pwWGXyXeOV27/oxT3h0J6g6eQpP/GxBhI48wJ4vTecF40siwFk1PU0KKV1
         1OuIDFLE/dAqOVL7VoGQiz+6EAwqmiUb6+zhI2fAawj+i7PcsHQkKJyZ3TFBOn74eV8H
         RpgyB78TULrmbOH6EW5SjawdQsAbqELZIORzW0S/rpO1hmvyioR5BmJ5p58tcdXuzTCV
         S7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771879983; x=1772484783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LMZVUbPRlhsPwvvYy5fOPbSt3iZilYmAeRJ1XOI+5wI=;
        b=KU4MEwt2OBh/DC06+TNRdEdI8BrWv9p88zk5uEVMlYLGZ3clNARcR37Is5r7k39AH1
         6R4VFLqU6kyqXpcbzRjL5uNg2QKFKTEYfuryzCKOytUaQiDPaVCbmQRlYgzB0yahgK8v
         Nx/5DEW0pEz873m0NiurEp4pkR0V2zPgBAbaZH55uao6gkPeNgCHMG6lCcCQ4EW6lTn7
         Iv9EPkoAcESOPTfiTSO4vxjzfZma+p8tngnjtHZtFsJT7XhqvQLjz71AOAdHsqKIXXnU
         kVTczLq1jOZVzCJGUyP5Cn4QCtzYiXAa/FCvNbjerc4QqpF13sEUYOe6rC047p8fMPvO
         J+Uw==
X-Gm-Message-State: AOJu0YyohJSiiAkBxHvj76KjVe3IUncBR9dTeiS6ybMMTnrtY3zmxnGL
	RH4pQlXOu5zoSJk8QxA2Vh5abDOmYGZYe2JtL4cnyWVyopxtAe+pvKb+wLbn7S8vr0CgkgsE7rE
	XG4VVv6UHU1sYkNC9PVNRxHrZwyWtga3FzmbIH/0Ev0Bn/YXheHTcfCskHonxXAsnvGBW453wDm
	TmS4UDnceAhIct8TCAJ4sXXgWqPmY7gM9/4vipt6WaVJMh
X-Gm-Gg: ATEYQzzlZZROTlzCHogmetCnBgxT+LwoPoNDOeOHuObKdo4a98lCvgPtKpfLqyPbqqf
	vdEKTV38er4neXL4Y+jU4ySc1CWBfPPWEZ/p1aNuIqimuto+gmNIlkxBw64KUA/0jIVlW65ueQk
	XPUV9JjVxwfxqINu4vSfkdpHsoBgBUk3DZLutn1TQ1N5i93EwBzimD2nOotd54aWxZVSRv4kEoB
	IvOTEqjRr+tT5ik8rEKukRR/K6cjqRorHpRopfL
X-Received: by 2002:ad4:4eed:0:b0:896:f42f:bf18 with SMTP id 6a1803df08f44-89979d7fb09mr142264886d6.54.1771879982637;
        Mon, 23 Feb 2026 12:53:02 -0800 (PST)
X-Received: by 2002:ad4:4eed:0:b0:896:f42f:bf18 with SMTP id
 6a1803df08f44-89979d7fb09mr142264526d6.54.1771879982042; Mon, 23 Feb 2026
 12:53:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223024854.18910-1-rosenp@gmail.com>
In-Reply-To: <20260223024854.18910-1-rosenp@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 21:52:51 +0100
X-Gm-Features: AaiRm51myZ0XPmTyc8ptgY48vi5mlFNztPXeF0Morq79CXan0I0UtBgybpkVAYo
Message-ID: <CAFEp6-1RM2KK4hGOPy0_gBbsymu8WsbpFyz-dUHxC3ys_AVeGg@mail.gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath10k: use non devm for nvmem_cell_get
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>,
        "open list:QUALCOMM ATHEROS ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 9n7d1gmrLEqljN79u6jv2OEkgsC4f62z
X-Authority-Analysis: v=2.4 cv=V7twEOni c=1 sm=1 tr=0 ts=699cbe2f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=laIMyccDeTmSpVvBuxYA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE4MSBTYWx0ZWRfX2D/EJbXRocvK
 Gf9vp8OFDaKbQHLaRPd6iQGWI/0+M29x4ueD682cLSDHPlY6g3HRH4UItsJhQ8z9kw++9DoyXm1
 iSI1I1HMcuU3vmgGzEmjl0dNHfgozypnn2iDtad8el21ZyaiDvtyrhX+Dj6YGMJlf0teEIOzSR0
 5il4trijCIn6JJJdT9Ci6CEUkv8vvTlOtTZBPfeTjKI2tdIVK6dOZZuoEjiHTsSrd8H6IPf7p1q
 e4Rd/Rv5MyVcoH9HTIde9ettBAHxB7qHqM6/myzFyRuf7eplJPdNfFJh3QCykaAdVFXcEkg6C2U
 6IlJNikRpWPdEWyR3PfVb4+Vk8GDTss5JuaDgDvwqau9RZ0e16MdjJd7i/iMFUm8LK9Fdp4e2EG
 Ed/a+Jn3LyIb5nyyFLq0n+EK/I0e8IqHHxPgJvL3j9xLh78PJrf9R8zy2vQfSWhTrz3Lwfk5aR4
 yQ8IriJFHkf0SFcqFgA==
X-Proofpoint-GUID: 9n7d1gmrLEqljN79u6jv2OEkgsC4f62z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230181
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32122-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim]
X-Rspamd-Queue-Id: 49A0517D3B9
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 3:49=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> There's absolutely no need to extend the lifetime of cell to post
> removal of the driver. It's only used in this function.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wireless/ath/ath10k/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireles=
s/ath/ath10k/core.c
> index 5c5bd5ef7175..38c5f5f95433 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -1981,13 +1981,14 @@ static int ath10k_download_cal_nvmem(struct ath10=
k *ar, const char *cell_name)
>         size_t len;
>         int ret;
>
> -       cell =3D devm_nvmem_cell_get(ar->dev, cell_name);
> +       cell =3D nvmem_cell_get(ar->dev, cell_name);
>         if (IS_ERR(cell)) {
>                 ret =3D PTR_ERR(cell);
>                 return ret;
>         }
>
>         buf =3D nvmem_cell_read(cell, &len);
> +       nvmem_cell_put(cell);
>         if (IS_ERR(buf))
>                 return PTR_ERR(buf);
>
> --
> 2.53.0
>
>

