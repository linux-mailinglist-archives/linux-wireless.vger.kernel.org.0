Return-Path: <linux-wireless+bounces-32348-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II8nEOeNpWmoDgYAu9opvQ
	(envelope-from <linux-wireless+bounces-32348-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 14:17:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7351D99E8
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Mar 2026 14:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A41A30134BD
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2026 13:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B012BCFB;
	Mon,  2 Mar 2026 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BWrQzMvq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z/Ts/REd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501FE20D4FF
	for <linux-wireless@vger.kernel.org>; Mon,  2 Mar 2026 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457443; cv=none; b=BlMK0EQw8bNsqcaKdkY7/skcx288vtOT8/XllmQvfeKnEb3yV2KiTYlOrRJAfgEkbolVAulYoTz5dRRjbDlnxQWoPRI87+xCcpog/RBhvIE7tOAQY6s8loaO+oxGkGSe+yy6smicKw3GLm2Rwi/kVR/y1CfMz53tJRKbbDNAips=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457443; c=relaxed/simple;
	bh=RQL+mSxhmcT5TrpWMkoN23SXgeMQBLcpauQocIuFg+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0fxMtqyJleA6LVBc2ouma6d/Va9qyHitgZjAJDf0GC6Ox3B/SJMr2MsoVjksQAY1OjaIuKBbMnm/Mz2qNMFjVNQHKM1fWNuaoL68jYIvwgzJCDdQsftaEpSbjdANTI5zTu5ZNO1G9ebF0KoLpP7ThseEaDHXSDSDZqbLFSYisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BWrQzMvq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z/Ts/REd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6229EwUS3630902
	for <linux-wireless@vger.kernel.org>; Mon, 2 Mar 2026 13:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zUZ1OjYmNYbdD1AD+KFKZfAvQkyG5i3hgwEtNFW530U=; b=BWrQzMvqNfBXyT0O
	Jn1LVEO6Dixr7Z3oufSlwdAwJR3IlqmGs8RN+7E8c64qtu9toTYU/qxiJnlIPKNv
	rwJah6yaa5EK+HaaFDu0Z5lIqJTEgmXu80gjc4yfnEHiEpWZnSDjljUzKV8Vfhgv
	H5ZNhWXfepvABBHKVLvTEDt7vVi9PK0QAlM9+CNgoXIwDcOXK8C0t42aWtaTzx+x
	FDwpejADascUWNfHE4v7v4USHyM6KLoZbXkCI5m1Hrmn1huh+2lD8SDaqERefK9W
	pfkHapCydZjwcuDR7yPjkYb36Ku2oWJjRcRxtZXjJNkiJSPyX35Igiyd5qn1Qiyk
	iGA/Fw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7rhrs8w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 13:17:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb3d11b913so3423141885a.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2026 05:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772457441; x=1773062241; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zUZ1OjYmNYbdD1AD+KFKZfAvQkyG5i3hgwEtNFW530U=;
        b=Z/Ts/REdN9Y4DCyBwgrAk6q6xtIn29/9GBfsNh/Rs/akpxxnGeHsDhceRI0W9/fP1N
         nCUi8OZO9ZcDxlkigQlHBW8heMEtPxaxdE2M6WBEfT8Ws/FLU5olE060m+PvtAKv+XLU
         6RZC+vhsB3xK1J+lBH8BYb1Kb21vKCjFtGo03gtR7/8sNnV5k0Je+10zONBF95oo8JDt
         a29mApUO0BTl4bUvZ/CZbGafxKv8gvLaBbb3bzEx1HAfWC5RTE7JCiYtCr6VZ7hG4yV3
         Nfe/9oG3+8rrH0seE6OS/bt/1KjrkpzGc2ox/jG36yKW4bcyOTG4nJrTEWNOPK4nk5Dg
         xwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772457441; x=1773062241;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUZ1OjYmNYbdD1AD+KFKZfAvQkyG5i3hgwEtNFW530U=;
        b=YFjRKUMoHCgs4OjAucEmymq6dv6e7Bx3RFRXTCTdzKp/2loZdLC3bAOSa02GzrMUld
         R5DzD/6adCn1cwKPmD+OHHHmw2PfT82XNb0D5fkjqsC4B1Hqhbft2/pRUumDzfMR8e5I
         A+7lFD9yBRPoeRoZ4r4z2KLcbSzugORNVIphn2Egrnxvcl8KgR/A4HBXHUK8QQnVamuW
         h+o/CFwpdtnBcl241FA39NTnNgnPTO3FStZOmWmC/Nw2legQYOqFooDH4mXTmW1DpfWl
         PUtr7CcEeqQXrQUUtjLV3G6sqzmLg8JgrW3zOb7s6YOGHwFam+zrJQVqc3cVzu3rK6dy
         BtUg==
X-Forwarded-Encrypted: i=1; AJvYcCWDKlZN9sS7j3FqBpCT/VVHv/dMhc/krN2eaA64Fe08WZICEXSsgbjqFdaIt445eQkAC1hHdFkIXEzPEwQ1OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAYj7yNVB1uzec5vNC7GYPnmmBZ0+L+BPkhURwYWuTkEpdu/cM
	YMEf+3nIJEaPli2kbc84c24ERoMuTsw6W3bw4LCgPHGdYVh6MYBJ3zYUU8Y+UjVNS/HKE18V/Al
	kBNNLiBhFf/+/Zbe0jrrkjVmkxmqVrKObn5WOu0cp7JNwj9dfxi8TzbimiL0AuGgQOWnk1Q==
X-Gm-Gg: ATEYQzzAPJFYeHAB3jgTKKbJ53dcpo5yRvQaclGU0Rzo8yDB9fAV6CTXPnl7Z3zv5+W
	8TQgd7ZXNx3FB/7FJoBdokWmIbHh3im8IclcNYU6RcdkqGsBxTvn0qUI3KShwaDw6/oQdc54rUO
	UOqttPSvySDids54wKKxTM8M26qGJcvjI66kAR49vwyNwFH8Hd6qAoIzqTlFKimv099DC2ggGgr
	BFLvdRgZxiGZmzjoY1GcGb7Q5t55ZnvT4gwOili2RqVicAkRQED/1+q1UmjVZVxUsl0ZoiNAC4k
	UbT0z3UqMuF8pSZ0dwrykOqFo/pOTTwbFOMmBL8h/pQKyti3MmGLkLrqfugln2sTLH6XWLMHYHT
	ncSjDUvUiZQ1NFFuwRJ22wWTp4pHqkFlCMeOVh2IMirB9hDADJItMf0U/vkFIerkA+SijtVMfLg
	1Vd6Yu/LoODPFZPTCxt0E7a9vXORC+ju2rsng=
X-Received: by 2002:a05:620a:199f:b0:8c5:3256:2f47 with SMTP id af79cd13be357-8cbc8e7885cmr1516174385a.68.1772457440551;
        Mon, 02 Mar 2026 05:17:20 -0800 (PST)
X-Received: by 2002:a05:620a:199f:b0:8c5:3256:2f47 with SMTP id af79cd13be357-8cbc8e7885cmr1516170185a.68.1772457440054;
        Mon, 02 Mar 2026 05:17:20 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a115a3f74dsm1676621e87.75.2026.03.02.05.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:17:19 -0800 (PST)
Date: Mon, 2 Mar 2026 15:17:17 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: =?utf-8?B?UmVuw6kgTcOpcm91?= <eldeinformatica@pm.me>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: CMA allocation fails with default 128M on X1E80100 (Lenovo
 21N1CT01WW) for ath12k
Message-ID: <ornmlrnmwzpxusdv7e5d27zvqn5ey73dt4gsh7kjrzvcbrrlrp@r5gaj7dphh4l>
References: <7pJkV7xouk-7S77gIvCwPj5EAAVe0JWdkD5Dc4Q7Y77_gPr5m7jMA2om7AyEN6RKBmEyFbIDJceHFstXFuzPJWPNhqafLXOu2O0uCDZEFcY=@pm.me>
 <05ff4122-1a8b-4728-81ac-33a7ca542461@oss.qualcomm.com>
 <d71ef31a-d7dd-4350-a784-a77e63be96ec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d71ef31a-d7dd-4350-a784-a77e63be96ec@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 45LK97cdlg_eXQ8X28ohzgkhjs9UwdYm
X-Proofpoint-GUID: 45LK97cdlg_eXQ8X28ohzgkhjs9UwdYm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDExMiBTYWx0ZWRfX1iakrFfDhJ6W
 0+8jLP9QWLnT88qwa/0vj1CsIxs/EyE8v40/6QBPn6ttPczxlxs+xLFuel8CpthvTsMytapiguF
 d/v6gvvZMRANOh+d20cPFxlYKI+eRWP0A8M4IM4W6pVO0NCQi4UDsXoursFwcnHGtuM/fYEJpyS
 G4KxrqUgbYkdRgjlQ6tBslmXCIxkDHDIk8qkiZM5wAYvty4ACPTPftHsxxkcaz5fRNLWwtz1PK+
 qlsQO7bEMccwSxruv4BEXbsJYwjnqjNYg7NTLhPaaB0Umuk5pVSqDBJ5gqMUCiqjKAFVSGqamf/
 l/3hKtdgkuJtOo6tRz+8qSdJnyaEG743PjD+omYACSiA8mmei2LgoSHVcPXne6m7hjeCigeyzHS
 psyGrAF/KFEk9D5Wal0M+vchi0ylrgxX/jwYH9SZpgRBIplNzeWmh4sN4z+tZMpW7JDS2XlwMat
 3rceItwhfVyKd2XbyuA==
X-Authority-Analysis: v=2.4 cv=cLntc1eN c=1 sm=1 tr=0 ts=69a58de1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pwxUH1OQPjk9tuu1yGIA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020112
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32348-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9C7351D99E8
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 12:20:17PM +0100, Konrad Dybcio wrote:
> On 3/2/26 12:19 PM, Konrad Dybcio wrote:
> > On 2/28/26 10:29 AM, René Mérou wrote:
> >> Hi,
> >> I'm experiencing CMA allocation failures with the ath12k WiFi driver on my new Lenovo 21N1CT01WW (Snapdragon X1E80100).
> >>
> >> Error in dmesg
> >>   cma: __cma_alloc: reserved: alloc failed, req-size: 257 pages, ret: -16
> >>   cma: => 1042 free of 32768 total pages
> >>
> >> System details
> >>     Kernel: 6.17.0-8-qcom-x1e (Ubuntu)
> >>     Default CMA size: 128M (set by the distribution for this hardware)
> >>     WiFi chip: ath12k_pci (Qualcomm WCN685x)
> >>
> >> What I found
> >>     With the default 128M CMA, the allocation of 257 pages (~1MB) fails
> >>     After increasing CMA to 256M (by adding cma=256M to the kernel command line), the error disappears and WiFi works correctly
> >>
> >> My questions
> >>     Is 128M expected to be sufficient for ath12k on this platform?
> >>     Could the driver be optimized to need less contiguous memory?
> >>     Should the default CMA size be increased to 256M for X1E80100 devices?
> > 
> > The default value in the arm64 defconfig is CONFIG_CMA_SIZE_MBYTES=32,
> > although most laptop DTs individually add a 128M zone under /reserved-memory
> > 
> > We should probably enlarge this value in either of those places, although I
> > don't know whether changing the defconfig is going to be welcomed..

Can we change DT instead of changing defconfig?

> 
> +CC FYI
> 
> Konrad

-- 
With best wishes
Dmitry

