Return-Path: <linux-wireless+bounces-14056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A43C9A01FB
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 08:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8181C21E48
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 06:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391A51B6D16;
	Wed, 16 Oct 2024 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUjsCVTX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C03199956;
	Wed, 16 Oct 2024 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061909; cv=none; b=OYIbwyV9UyiHdtZjvXpmFcBpWICphqLAG+iwVuKelw1fJAzlunS3LpmXmEd9YmSiuIhpIhR6T+Oy2g+ppWgs+mr/vV4wGYpm8fl8uBQRCKfSl54cY08a4MpfdOGzExQ/WqP9v8IsgQj7u70bmWUa63BQlhGLsbuthGJWF21Z/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061909; c=relaxed/simple;
	bh=WfFXzP8/c3J6x7qT5BMt6TQD7XOC91zd+5me5pZif4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6cGeh5xQ7VAJ0v/CxYQSGaMDhnGUBKlKZG0lib6mzNrF1jg5VD6BofzKNOzqxGF9jJHkcBDIDEQC1eIVFxE6cn2TGaafwT4npf8XmrQB8Bul7AlPZntg4Vsk66wftH5ZnDGdfGdcIPNGY39XXWA40TeqVZxF2KJWaMdHn1FZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUjsCVTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C93C4CEC5;
	Wed, 16 Oct 2024 06:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729061908;
	bh=WfFXzP8/c3J6x7qT5BMt6TQD7XOC91zd+5me5pZif4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AUjsCVTXoxv908D/ByuH8Dh7gzXSKGadgwOvAqCmNK35myX33J45uDHXIPm7mDJQ1
	 hKEdofn2ShES8lnHcGoGVGq4mxfQSckwZ85dKYkkz8C5ca3o1hSraRZk69bLELzopE
	 RI2QpZKhTlk2NzZ7JrHeCr86AI701yCnAEP6hrpR92O0VWqL94ivu9D5b5/SBa74wo
	 XdvG9vh2ig618pjARQs3qewdQtxdAwIV+KGS1eF9AvXMHHRKK0Fb8GnUvLXyHj6JI0
	 X1syHiQZIXJdjJwkj0hY3vBy/UudnN2/+Wr9n+IxFyQSg2kYpBtKP1xLABEv0fYpYg
	 BvZkOPS+mdlDA==
Date: Wed, 16 Oct 2024 08:58:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	Kalle Valo <kvalo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 02/22] arm64: dts: qcom: add wifi node for IPQ5332
 based RDP441
Message-ID: <ftvwsizfupm7veg662adnzc6jpulk5shga3xmvbtom3saclnf6@bmatmqw5lp72>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-3-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241015182637.955753-3-quic_rajkbhag@quicinc.com>

On Tue, Oct 15, 2024 at 11:56:17PM +0530, Raj Kumar Bhagat wrote:
> RDP441 is based on IPQ5332. It has inbuilt AHB bus based IPQ5332 WiFi
> device.
> 
> Describe and add WiFi node for RDP441. Also, reserve the memory
> required by IPQ5332 firmware.
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

Don't send one DTS patch in 22 patchset targetting different subsystem.
Imagine, how wireless maintainers are supposed to apply their bits? 21
commands instead of one command?

Best regards,
Krzysztof


