Return-Path: <linux-wireless+bounces-7449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 135038C2375
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 13:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71851F256E7
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 11:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9441179654;
	Fri, 10 May 2024 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jgparnqh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C75179647
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340463; cv=none; b=cticQSKaLx8Fe9h3Dj8oJZHC1jN7lBDrlrfOLcOobez2wl4IpXXu9QjTnLG7ExYoDV0V7hCGEKHVwhQdgOzlLOwo3Ef+6up5IKdokQwnjI0apzS25V2EVRe6UAmd4t9a4G5uxiJ1KAmwlpnEC95jdnnvuMK5mh2xbPmXz+6nqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340463; c=relaxed/simple;
	bh=gF+sa+/XGxSbfjHvq4RInnphfam85m2+QW7/nTCMInA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=TU5Nk/FcUZlaNXvhUVrKhd10BzT1AKEikzPHOZMs2tjazRkgtci2al/hJjtwQgFirJ+xlQdbw85qWfWQfWl8UHU+cKdIbHAoL6JdsElcLKKgCaoBGAu4+ItYAJFMfPC4MtwiWwtJOQAMiGv2SjQ1P87XE2qJgsFzgkOWYsNbQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jgparnqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B50C4AF10;
	Fri, 10 May 2024 11:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340463;
	bh=gF+sa+/XGxSbfjHvq4RInnphfam85m2+QW7/nTCMInA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Jgparnqhpv3MxZBblsyAQYByv5KNh1CBCWb/rJgXzSrwDxrjt+tnJFxaMO5cPgUnL
	 Gor6V8a6TElsmmWpx078XjawHwdOiqx7RC04+KFIZeo8NIJT2NJeWImIISpJBpqtpL
	 iNdn9YkIz+m2r45hRMsTTUkZDjRC6mU/c19ONAxCYhlxFT0IBg1dEbCGBinQdRljtG
	 2+y4h1ijEcJfHGLal2ngOdHCC4eL86IxPDwk6jEfE4MXT5KXFFI1hfPOwwbBSTPeWW
	 TVOW61iTGvQ/eGz2pD45D9LZ2K9cAq/Jf80/OEkm+xZS6OUeKkepqtal+CpQWmDk8v
	 y3XzFxYvO1FvA==
From: Kalle Valo <kvalo@kernel.org>
To: kangyang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: ath12k: remove redundant peer delete for WCN7850
References: <20240510111238.1113-1-quic_kangyang@quicinc.com>
Date: Fri, 10 May 2024 14:27:40 +0300
In-Reply-To: <20240510111238.1113-1-quic_kangyang@quicinc.com> (kangyang's
	message of "Fri, 10 May 2024 19:12:38 +0800")
Message-ID: <87fruplxeb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kangyang <quic_kangyang@quicinc.com> writes:

> From: Kang Yang <quic_kangyang@quicinc.com>

Please fix your git config, it looks your name in email From header is
formatted wrong:

From: kangyang <quic_kangyang@quicinc.com>

https://lore.kernel.org/ath12k/20240510111238.1113-1-quic_kangyang@quicinc.com/raw

I guess it should be like this:

From: Kang Yang <quic_kangyang@quicinc.com>

Though I'm not sure what kind of formatting you prefer, please just pick
one and use it consistently :) No need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

