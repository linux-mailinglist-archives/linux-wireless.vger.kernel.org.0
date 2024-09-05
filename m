Return-Path: <linux-wireless+bounces-12544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8629096E105
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 19:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF3A1F24EE5
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 17:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C97F1A08AB;
	Thu,  5 Sep 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="KaXKbiH4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDA6192D96;
	Thu,  5 Sep 2024 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725557006; cv=none; b=fn59CY+9RAGLfFJ2rEa/A8wuIVX9/BJWb4+MDyyEpsmQbUPL/JAGQ4rvB46aWJXzGVpZgMX5QCKon6AxK/I9PG2IRHZP9mYh0CVyuNxHJk45GLR2Q4cklbCa1XDanGymmKw0JVt+wAtdpqDftTkCROnYjytXLB6/3jF9589kjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725557006; c=relaxed/simple;
	bh=SsFYSVZGNNvhMoCE02ooVAmH9F/EfAS6q2bU8H/GyNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9GCMdoQq9zkuym+0M2nXjpYnSCStORLFS75A6ehMEciaYeauNTVCOP/C1qC9MOmj/qvceaOp8EaxunGi9ughkt3Cdw3/VOrfyPNRogxZMvgIBwIdQxOUKiPozKQ61U1753NHFdp7e7FNo+bcI5MOwNCEd2BtkiZFDSHgXCGsp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=KaXKbiH4; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QvnUGQkoVfJsMoaXXAXHli63RR+QFr4wc56F+EvuEmo=; b=KaXKbiH4S1iDfC2llqeoAU8GCi
	0tkTIi66nm1aLo+V3lKpC3t7/N/75NNJKPDhlYN7tEsDojD25GOWlS5HS+IxvOixU7cB0v4MTd51U
	8KN41ftKEjNTwAOaZ6uvdCGoHxk+lAmXw993qbI6OVEWcAcVErFqeumBNn2abQpFc+mc=;
Received: from p4ff1376f.dip0.t-ipconnect.de ([79.241.55.111] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1smGCK-009Kc9-1p;
	Thu, 05 Sep 2024 19:23:08 +0200
Message-ID: <a2746d9b-60a3-4cdc-a966-24602f1b7ade@nbd.name>
Date: Thu, 5 Sep 2024 19:23:07 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] wifi: mt76: mt7915: add wds support when wed is
 enabled
To: Shengyu Qu <wiagn233@outlook.com>, lorenzo@kernel.org,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com,
 kvalo@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, daniel@makrotopia.org,
 miriam.rachel.korenblit@intel.com, money.wang@mediatek.com,
 StanleyYP.Wang@mediatek.com, meichia.chiu@mediatek.com,
 chui-hao.chiu@mediatek.com, johannes.berg@intel.com, quic_adisi@quicinc.com,
 sujuan.chen@mediatek.com, allen.ye@mediatek.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Bo Jiao <bo.jiao@mediatek.com>
References: <TY3P286MB26111E4DB0841A176DF8E44E98BE2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <49a385d0-9ffc-468f-b7de-83abfa1e18f0@nbd.name>
 <TYCPR01MB84378D62952D1411BF46EC00989D2@TYCPR01MB8437.jpnprd01.prod.outlook.com>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <TYCPR01MB84378D62952D1411BF46EC00989D2@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.24 19:10, Shengyu Qu wrote:
> Hello Felix,
> 
> Which git repo should I base on? Is this one?
> https://github.com/nbd168/wireless
> Or use wireless-next repo at git.kernel.org?

Please use my github tree.

Thanks,

- Felix


