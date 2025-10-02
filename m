Return-Path: <linux-wireless+bounces-27771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 329CEBB2280
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 02:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0A317AA08
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 00:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082673A1CD;
	Thu,  2 Oct 2025 00:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="Kf+zPFMx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jmJBmgC2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD75227;
	Thu,  2 Oct 2025 00:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759365495; cv=none; b=m58R0JYV3sunhK8W3XHpf+6mpGyZnYq5Nm+ld1pNH7aRA4YYIcJhWWag0ulcGDbJJvwB2GTIMSLJE0vjjgwds+EMZ7k5C7dF/eXgUlzyPutVABgG8JFEwxrFgqw2l1KzLeG48d55eKb00QbLRBQXSPn7N73yaLaiKDSMOPxDrUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759365495; c=relaxed/simple;
	bh=yiGqpjlugDnwUV/gpvGALmUpFwBg3RZ0udGdAb6TxUM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hDve//jKJqLkeQxNijSj2gvBFCCCe5NJrSeHuYYME6Ef8EBLtZcxir9Vhb9/5HRZq/FrPakr0nRJVQ+a1BQwblIcvf1uG/MCFraLCx4pxF34/mAQEmemF60gBUqE6YNozB0eu5nUgSb/E2nrfwpUj68RsY2YRuzLD3TsfckTnh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=Kf+zPFMx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jmJBmgC2; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5F91814000DA;
	Wed,  1 Oct 2025 20:38:12 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Wed, 01 Oct 2025 20:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1759365492;
	 x=1759451892; bh=y7XMYXKoKf0KXuqzI3qHzhDk9NpiNn7xmPgDTKLecJQ=; b=
	Kf+zPFMx3dwFuBg2v1PfSBlg5Q6lEYzOO1Dhoi3YZJinZyXjre2J09QBIgh2zUm6
	HciQFPA9+QOlpkz9gmaE7Avh5O0FSbFG86lOKfSBkYTGszmg+2s5y4YhNCsqop0Q
	QahKHg0DM+0G/N40f6t91EDrM53awDP99znMN8iGNkDwXIYpHSIRkLJO8knz9jo/
	BPM+4dIuwhWt6B70+n3qOIwT1HAsaGzQt8eeEwtoSWIPxaGE6ctcOdKi1jPuYKgA
	OEbMYf1zzzVvNrC5XB3sdruV12HXA48f9FtGq6iPDNwPHVQ1SZHNR/xF6lTDTofA
	zrV3L58X216DnYZRNGaCPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759365492; x=
	1759451892; bh=y7XMYXKoKf0KXuqzI3qHzhDk9NpiNn7xmPgDTKLecJQ=; b=j
	mJBmgC2TiRhcSrvir5NXszPUb8iYy/BK6aItJ+S3Nw5yT/mq207btOXAcMJzCzb6
	qOh1OnymwuK66KaDaMrxkyQ5b846T5Ar+Zoj7uB0aCKUg0+zrJMzscccTuGhapaK
	tG73wAlZSBMWcZpEGfpGuPtSyyJA1V8V4QY1ZkAVhrYIuIY4iQq6ACateNNJQWYq
	iGrCr9Hk4Z5wMX4sPqlAy6J0ILMchyiHr3zMSsfWIngh07FtMuEV1vmporQAMVMo
	bx9ixN9Qd9OpajyROGdIPpjp4KjuygkCLmIBQFSjEIbJ3Z+Am01A7GDg/qSHzPIV
	2wVlDQ2G8bET0rrrl6OEA==
X-ME-Sender: <xms:c8ndaNCyubPts32vktkvpck5YQ8hPq3WnHA08eF-opovGzjXzXKlUA>
    <xme:c8ndaGXWBnB-K2JaJ9czId1wrC74uiusjvU-KM4PRRrIGgbn9bMHqbhCNA_STaWVb
    dJpxw4t5j9HG8af2xClzNwAqcnUxLEz-gYRF1i8nzBVdCY3G-7IWck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgeehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdforghrkhcu
    rfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
    eqnecuggftrfgrthhtvghrnheptdffvefgtefhveetuddvfeelveektdduvdelgfehgfei
    keffjeetjeevffektdfhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdq
    lhgvnhhovhhosehsqhhuvggssgdrtggrpdhnsggprhgtphhtthhopeeipdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehjjhhohhhnshhonheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghthhduudhksehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtg
    hpthhtohepsggrohgthhgvnhdrqhhirghnghesohhsshdrqhhurghltghomhhmrdgtohhm
    pdhrtghpthhtohepjhgvfhhfrdhjohhhnhhsohhnsehoshhsrdhquhgrlhgtohhmmhdrtg
    homhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:c8ndaCpxaw5eWMM_lysJuY986eEIzWl1yHJFaM9-n3dAxsNEqTv2Vw>
    <xmx:c8ndaKtKcLyphnS9SoMQ4fKdIbS-bq2ntk5AYS1N0n_FUHr3BadsNA>
    <xmx:c8ndaHHIY7L47Vt1YOwhW8Ntj2Au7rt639GKEfOB_eP6KG2tsAnu_w>
    <xmx:c8ndaDbZJu81EkiBUn3E6WfnU1QKNXrxG49pX9sIEZmwJq66QAEo2Q>
    <xmx:dMndaDm1EK1CDcprAfStrdA57oEFdI0938nour6KERG58Dsz6iFocJME>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A204C2CE007E; Wed,  1 Oct 2025 20:38:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVTq1tek_bVo
Date: Wed, 01 Oct 2025 20:37:51 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>,
 "Baochen Qiang" <baochen.qiang@oss.qualcomm.com>
Cc: jjohnson@kernel.org, ath11k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <d7f00754-60fb-4ecb-adaf-a706121e757c@app.fastmail.com>
In-Reply-To: <85b5f6ab-a372-4ccf-b41f-67c1d22df3f0@oss.qualcomm.com>
References: <mpearson-lenovo@squebb.ca>
 <20250929192146.1789648-1-mpearson-lenovo@squebb.ca>
 <83de6105-ef4c-48dc-8960-430893ae253e@oss.qualcomm.com>
 <85b5f6ab-a372-4ccf-b41f-67c1d22df3f0@oss.qualcomm.com>
Subject: Re: [PATCH v2] wifi: ath11k: Add missing platform IDs for quirk table
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Wed, Oct 1, 2025, at 8:11 PM, Jeff Johnson wrote:
> On 9/29/2025 7:17 PM, Baochen Qiang wrote:
>> On 9/30/2025 3:21 AM, Mark Pearson wrote:
> ...>> +		.matches = { /*P16s G2 AMD #1 */
> ...>> +		.matches = { /*P16s G2 AMD #2 */
> ...>> +		.matches = { /*T14s G4 AMD #1 */
> ...>> +		.matches = { /*T14s G4 AMD #2 */
>
> In addition to Baochen's comments, in my pending branch I've also fixed these
> 4 instances of missing space after /*
>
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=79208b9ac68a7e71ad7e60cc37038c35b2b4252f

Thanks Jeff

Mark

