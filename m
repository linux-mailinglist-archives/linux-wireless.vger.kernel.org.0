Return-Path: <linux-wireless+bounces-29437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABC0C9592E
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Dec 2025 03:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A77384E10EA
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Dec 2025 02:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75111A2C11;
	Mon,  1 Dec 2025 02:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGSoaUqy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38791A23A4;
	Mon,  1 Dec 2025 02:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764555449; cv=none; b=IhC0tfYPfIFdpPxvdkuh/r+Ju6aVvNTcU8T47SApZ4iB7RxD5g15r2HzqPrtj8gILttTTAFKqlo4OyYLnW3/e9yvThB+IUC/X8xkxw2D7IkcjHXP6O8bQEtfySt22f8GtOv4sijvj1d430XyOe1PJLAUOnOFzEnaFDHdHboW9lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764555449; c=relaxed/simple;
	bh=qAR4s+Sscu888FeC6OAcpjCUzMfZfymLy2FSxVamYDg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=GrMJb+XwpwTtFYy31Nps8EsIELtg2nJmi08o0S75mEeEWZkZ6g032ZbJCIVvjsgyuc6anZf9y5PxpZLBztOSR5Er/gE1L5gQTjaDYbUyXrRz7NsaWlYMu9bEdQm6fBNtBwPHsdWEQvuKyRA733p94lTt6Q+OWo98RHu328f9B9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGSoaUqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE52C116B1;
	Mon,  1 Dec 2025 02:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764555449;
	bh=qAR4s+Sscu888FeC6OAcpjCUzMfZfymLy2FSxVamYDg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=hGSoaUqyPnJR3vfA76Yf72BR0NW64ieqH6jU+UOq61BFL7JyN4zpRAZln8yvAeIwt
	 OH4MoOGpwjQz48oN1FVxneNHmJVUUsRXeR9hGcQXoMHitCKOLiGizqFSP7JAIYEfVR
	 BmdbvSutzNodrFlfOCkRVFaITuwmJpCUZ/nnasjxk+yR7Nyyjyoqh7IUqAU2OSRANU
	 gez9hzW5Od3lTBaMYiaPnOvnQGdapn+11xkfC/aFwm6E7T8ZPTYaVlynHGOPI1S8tP
	 QqRY83EXJSw+8Ozn5sEeIezR+B+Z3WcjK783OWiUNk3RQXYZufjSlgWYZFwssMyAqf
	 7FvXfWUPhXjkQ==
Date: Sun, 30 Nov 2025 20:17:28 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org, 
 Johannes Berg <johannes@sipsolutions.net>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 Conor Dooley <conor+dt@kernel.org>, ath12k@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Dale Whinham <daleyo@gmail.com>
In-Reply-To: <20251201011457.17422-7-daleyo@gmail.com>
References: <20251201011457.17422-1-daleyo@gmail.com>
 <20251201011457.17422-7-daleyo@gmail.com>
Message-Id: <176455544616.1847608.6932629512199964095.robh@kernel.org>
Subject: Re: [PATCH v2 6/8] dt-bindings: wireless: ath12k: Add
 disable-rfkill property


On Mon, 01 Dec 2025 01:14:47 +0000, Dale Whinham wrote:
> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> 
> rfkill should be disabled according to the Surface Pro 11's DSDT.
> 
> https://lore.kernel.org/all/20250113074810.29729-3-quic_lingbok@quicinc.com/
> has added support to read the ACPI bitflag when ACPI is supported.
> 
> Document the disable-rfkill property to expose one specific feature
> (DISABLE_RFKILL_BIT) for devices described with a DT, so that the
> feature can be disabled.
> 
> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> Signed-off-by: Dale Whinham <daleyo@gmail.com>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath12k.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251201011457.17422-7-daleyo@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


