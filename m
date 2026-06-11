Return-Path: <linux-wireless+bounces-37680-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iRPnNEMQK2pJ2AMAu9opvQ
	(envelope-from <linux-wireless+bounces-37680-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 21:45:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9FA674D69
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 21:45:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NsgxwsD3;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ChWt09wZ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37680-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37680-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39DF830391EC
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 19:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9B33793CC;
	Thu, 11 Jun 2026 19:45:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3307D378D71
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 19:45:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781207105; cv=none; b=QXEBy9hqDuzOewpUQv0iw5/qiSBsefge/sYJ/zgAcgMzjqX5MP7kAsn0lnSHyb2bbel/9sZjZKPqxPTgTPMtZex982P3WO5DyDBmoU1gczQ56FTXYRvkeDRZHUzXLW2z4WOofWTKUPG6OzCfXEO47XFT2e8AMxG0cINABk2PmAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781207105; c=relaxed/simple;
	bh=01ioWAHb5nCsaIc11XbExlYS4Qk3/qMPjNMVsOpw1as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+drvFKSH6uAUnVhaqAZTVmTrlN1DLxlvgt7MuXCTBds65wgWKmLG7Gb8v1hyeLXZhaii0WFwJdyoFxEOid2Raiuo1iB52qdJyd1hbsCVma3jbfqr/fNLYDWOmdWHwp61rt87Wl2vDMhG35Ns3eoTex0kG3ScnVx+3F1hhAqdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NsgxwsD3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ChWt09wZ; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BJ3RBl1479968
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 19:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ET6MuyER7wxqL0ASDlEV4k/M
	QK1DNFn9BvrzLC069vE=; b=NsgxwsD3g9/tq9EhZ6i+/tcISCfFF7/04AjnxCFQ
	Ml6KjDCaTQdVQ7/O+jrLiaCqhWqWALIh+4xScFrNXEJjaxa1e99uVeRza6pIO8kS
	6hcsGgFXizRuscbj97lpaijwrWQV32/x0QIgBLPfPHqms3EOJ/heK1CG59rjJks8
	XV6fgwZKlJCHBOm0dRHCYTgP9E+a8EAYjLoul37S9v7b3hIxpOEZW8RMrrxqWjId
	vv3NZrNwStAj/Ls5lRcxQqAhDm2KQ4s1hfuEc5mXEJ+IjcJuAYgagI1a3Cklagkc
	U/PqeV6jk8kaHrttj5udUw1psw4Zas8zGTIZ5y9LooMAnA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er0x7grhp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 19:45:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51775f7b2afso24423481cf.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781207102; x=1781811902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ET6MuyER7wxqL0ASDlEV4k/MQK1DNFn9BvrzLC069vE=;
        b=ChWt09wZlxE5j1/g37hBp5uXGbKO3DITbM5UEWqcp6HjvCdkXcxW5JJ/yGswHUFnoh
         KMICONwmJTHsYjM7qc3gaPB38fzQjhrX8fHA/Gjt2ptoMqQPskck/aLvrF9RdDasNT98
         t6EdtAkki3lZq7TRTvJZ6Yicazt7hDL72Amutc2l2QvGf4zrlx8ScuV6lyhIYP3yJr7h
         gxnNqHzXgTZDW8DNipL5C99ueaWKlMXQbPFdgyzme26GPweMdfDe3uCp7c0R/ZJUF9Ek
         YlAebBhW9AFwK9EMfmBCpwkhYYRkWhOCIfjOhBlmNe4FVrvwuLzk5LkgMgodpnoKpQqX
         ntrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781207102; x=1781811902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ET6MuyER7wxqL0ASDlEV4k/MQK1DNFn9BvrzLC069vE=;
        b=VYF21qVyCPpdHuYyJvd23teA/KAOQdbV1Ls4LpuIaMwa+VNLMMdvRBlP1QCJOzZ7k9
         sS7AwEMRY0pUFt8J4VdqEttbuUjUigdowl+3rvGRR9WcwOFMi32AtTihgxaZD3Eeu+Hq
         PsR3OjoirLFl+u66Yv2pSs8qk2er7oIq0Ti70fnX8u1Khz31Q6mQ9jqL8IjgtZoGG6Bw
         jZKt/7LgqtIUm49sha5Gp/v5HBJYiXKqKCp75uNfTayjOLaywLlqQwAR1ZML+iXsjeCw
         OF+ty6PgqBZOjM3IflF4msyGTTmbHAmnyeA1iQHN+a3adK+Njzq2+JQoXgIBFNc4cCAu
         bHEg==
X-Forwarded-Encrypted: i=1; AFNElJ+rGBS4DPzIRbvcSwOKqFILRXrAMV16TcWWaPCtrbiS/+68btYiQCSsr6uGJaHGsgM3nqGoy+Ui2aUG/r1W2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ItUULKmssNLe/PfMeXpWO3vbeKtoueWLPav6j4yMNdhycyls
	JxfKxScgubfqrIv92Kf+eEzPJeCq54K4ceqWgeC9lkOFS8oITnjTyTv+koaX5oRMghEkTs6Ctcb
	t+NE+IIq/lcqi57IT0F47WbZiJZmrdS/rVL+eWkvCBTGFAHlawio+jSEY5uQzEz4P1uoKDg==
X-Gm-Gg: Acq92OE5ZUtXQNnaU4cCjhAF3lpyxB5uuBUUOwRv6tfdKereGQOidqZwkrDXz4WAi6b
	JI+VyHJs0JThlWNVSlFIHhNaW7SeC7besNouZZYD2JrK6O+Q6qrDyZbb5W0NfZi7BDQ1zBd/Fnq
	MIMYW9v553bvn0gJh+ZEx3fvCaMuuGmjlO6coxoMlqw6vL6Wz1rjDK+dYugmj++U8IV3RYzC/Kx
	iPRUr4JjZO4CxqDQ7/VXTAGb2fBgTgME34fK/UtDeGYJlsMRn6Om4lbhtHWgPoq/Nakq+YGSTCE
	QMv0pABYiUL3y4cp8MWkTKBfoqobWch/hU266kTtIpMb7Z7jkbmew1kAu9FXm1AQtyefpi8PsPa
	2Vq+vtK0D+w+hTZEGKRjy2QGGHJjKI/TucCJ9sIGksZ362+TzGl+9R8MFdMQSk2OTJI6UyPN6t6
	3SD2BE5XP4cgR1yCvRTFNbfmWv3x3+TyfkQXA=
X-Received: by 2002:a05:622a:14c8:b0:516:ddfa:b6b9 with SMTP id d75a77b69052e-517fbe619e8mr1985061cf.23.1781207102484;
        Thu, 11 Jun 2026 12:45:02 -0700 (PDT)
X-Received: by 2002:a05:622a:14c8:b0:516:ddfa:b6b9 with SMTP id d75a77b69052e-517fbe619e8mr1984411cf.23.1781207101976;
        Thu, 11 Jun 2026 12:45:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2cb46b25sm103098e87.34.2026.06.11.12.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 12:45:00 -0700 (PDT)
Date: Thu, 11 Jun 2026 22:44:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip
Message-ID: <dz4qovpquxgynnzviqg6g23oa2o3trlkznremnmlqfnlj3b62x@oqgcuvalfcph>
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
 <20260601-sm8350-wifi-v1-7-242917d88031@oss.qualcomm.com>
 <955691e1-e40d-4584-861e-8f29db4ba8a9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <955691e1-e40d-4584-861e-8f29db4ba8a9@oss.qualcomm.com>
X-Proofpoint-GUID: L93c8bmN98kSvRDTOvSh2XhbFVeodW9l
X-Authority-Analysis: v=2.4 cv=c4abhx9l c=1 sm=1 tr=0 ts=6a2b103f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=NvgA2eVT_OJx7K5CLicA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE5OCBTYWx0ZWRfXzHmswM2zZevu
 A4tTNDbKU+1s2KDja2FhE6gAQdRAQLuK1wjKcdbIIfzloSmSNOYZ/KSfFjrbSe+yVbjSOPOJ+Aa
 e1CoOusAh+r+Hjgif2z+p1RrOKdLZ1tWh1M0UFK6QFM2eIVXquN9dTsge7/KuKF2OZ7KXsnVrxP
 efszLKHhrvjecEyLa5dEbhT9/loXvyGt7A9E33T+wbXkexWkoPeVwiESPbzMwWkfxqm+Olu+ugv
 PCsXa7AhrJuXU7cvDsP57HwSXHrXSeG4ER8E/ktpEMG6gKlsN+l+kwfcpa0fexyBshms3MpFtXB
 a3qc+RwE3kSxy+O0HlaN8OiIU/1p+yqgjqqajM6BaLpDLx9qpRaNxJcQ0Y8evyZDCtbJDKAnWSC
 5TgGXACdwZIyqsTiWWGge9PFCV7o94o1Kbe6XoFIjbqIb9bZa98t833f62XkCqUH9BRqVgI2xRh
 lAQce86mGKVUAW4PZCg==
X-Proofpoint-ORIG-GUID: L93c8bmN98kSvRDTOvSh2XhbFVeodW9l
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE5OCBTYWx0ZWRfX0OLJ6fOvf/UP
 74WU4THBdYr6N7enD/DzOhWww4pnI88izt803B8dhHKIoxjyzgnn5cmivqZsdEy0jviUXpx3pVx
 y5Y2phf+NwEzRI1I89n6FTKqTeGEpRA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110198
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37680-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:konrad.dybcio@oss.qualcomm.com,m:mani@kernel.org,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:qiang.yu@oss.qualcomm.com,m:jjohnson@kernel.org,m:lgirdwood@gmail.com,m:broonie@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:devicetree@vger.kernel.org,m:brgl@bgdev.pl,m:linux-bluetooth@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com,vger.kernel.org,lists.infradead.org,bgdev.pl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oqgcuvalfcph:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D9FA674D69

On Thu, Jun 11, 2026 at 02:09:27PM +0200, Konrad Dybcio wrote:
> On 6/1/26 11:46 AM, Dmitry Baryshkov wrote:
> > The SM8350 HDK has onboard WiFi/BT chip, WCN6851. It is an earlier
> > version of well-known WCN6855 WiFI/BT SoC. Describe the PMU, BT and WiFI
> > parts of the device.
> 
> [...]
> 
> > +	wcn6855-pmu {
> > +		compatible = "qcom,wcn6851-pmu", "qcom,wcn6855-pmu";
> > +
> > +		pinctrl-0 = <&bt_en>, <&wlan_en>, <&swctrl>;
> > +		pinctrl-names = "default";
> > +
> > +		wlan-enable-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
> > +		bt-enable-gpios = <&tlmm 65 GPIO_ACTIVE_HIGH>;
> > +		swctrl-gpios = <&tlmm 153 GPIO_ACTIVE_HIGH>;
> > +
> > +		vddio-supply = <&vreg_s10b_1p8>;
> > +		vddaon-supply = <&vreg_s11b_0p95>;
> > +		vddpmu-supply = <&vreg_s11b_0p95>;
> > +		vddpmumx-supply = <&vreg_s2e_0p85>;
> > +		vddpmucx-supply = <&vreg_s11b_0p95>;
> > +		vddrfa0p95-supply = <&vreg_s11b_0p95>;
> > +		vddrfa1p3-supply = <&vreg_s12b_1p25>;
> > +		vddrfa1p9-supply = <&vreg_s1c_1p86>;
> > +		vddpcie1p3-supply = <&vreg_s12b_1p25>;
> > +		vddpcie1p9-supply = <&vreg_s1c_1p86>;
> 
> [...]
> 
> > @@ -373,6 +437,13 @@ vreg_l7e_2p8: ldo7 {
> >  			regulator-name = "vreg_l7e_2p8";
> >  			regulator-min-microvolt = <2800000>;
> >  			regulator-max-microvolt = <2800000>;
> > +
> > +			/*
> > +			 * This is used by the RF front-end for which there is
> > +			 * no way to represent it in DT (yet?).
> > +			 */
> > +			regulator-boot-on;
> > +			regulator-always-on;
> 
> msm-5.4 maps this to bt-vdd-asd-supply (asd being a keyboard smash,
> perhaps?) - what is its actual use?

WiFI/BT RF front-end, a separate chip containing amplifiers, couplers,
etc.

It is a separate chip (or a module), it is not powered on by the PMU,
etc.

-- 
With best wishes
Dmitry

