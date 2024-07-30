Return-Path: <linux-wireless+bounces-10681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0708940FA0
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 12:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3632829D5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 10:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9371119884A;
	Tue, 30 Jul 2024 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qbz+i/Cc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6518E771;
	Tue, 30 Jul 2024 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335711; cv=none; b=N/itRyVinH1VrD2zPyqVmLYgq70f80g5oy5Y2dwTeepC3viSLxrfm9Bire0qtA3Yzs/HOojJk7FukGpj2sxpSNopXO53fjZRNF3nhm/rc94ORwh/u7Cv2EHYdb68vnBYZVlWVC6OdfZxQDWZY6QwW16M9zBneXfyKR3zpm0vBFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335711; c=relaxed/simple;
	bh=OqxNeHY/v/ofIyNQ5/aXLZvlFKdi959PW4sxej3ug0g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MSk6LFgFDcSWZRhRnpupppVLIRzIkxyvQEmgb7x27HAUG7HpJL227slnttkEkf9bQJ0CX25P0tvBfsJSLEiERqOKOvDawQUF5Jif3XDNhWFWWEZUCnqTlIxKpLNKEyqlLXvXuihlDe5RRDJL/PUTqPe6NrTqwjN7LaMKwk9ISEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qbz+i/Cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC1EC32782;
	Tue, 30 Jul 2024 10:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722335711;
	bh=OqxNeHY/v/ofIyNQ5/aXLZvlFKdi959PW4sxej3ug0g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Qbz+i/Cco0lnSDPNjQN+SaRbmxOshKdQC6MssEjqIU6ejREpmK2scACSon+eU76dg
	 uYe69ibi8IJzSVqVr6vW7wUgyQ+/dY4vSQ1fT5X2mahlxnoruM8yo6Vki9v1RBpyXM
	 tyhgbPaHcNhjnkWPiQoJ2cqOaZ6LKsWbw0Hoh79JzhlFVDlux2rIJotqegxuDVKsE2
	 2CqnoHRtQ7Y5hwcGE5+uoj6u0AHG6RIKT077wAOsCcCFVC1BwSMwPuirOAVejpkbWo
	 Hc26awOAqsbdxOZ6koziZZmWFOB2G0t+LSQLJ2IP17Y7hlfHGlmdc5aN5ArUqIv3lH
	 kZ73tPfdGQbAA==
From: Kalle Valo <kvalo@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+51a42f7c2e399392ea82@syzkaller.appspotmail.com,
  linux-kernel@vger.kernel.org,  linux-usb@vger.kernel.org,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  srini.raju@purelifi.com,  syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] wifi: plfxlc: remove assert for mac->lock
References: <000000000000ac553b061e675573@google.com>
	<tencent_03969636CA4BC874A7763F66D23D15366009@qq.com>
Date: Tue, 30 Jul 2024 13:35:07 +0300
In-Reply-To: <tencent_03969636CA4BC874A7763F66D23D15366009@qq.com> (Edward
	Adam Davis's message of "Tue, 30 Jul 2024 12:28:42 +0800")
Message-ID: <877cd39nhg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Edward Adam Davis <eadavis@qq.com> writes:

> syzbot report WARNING in plfxlc_mac_release, according to the context,
> there is not need assert for mac->lock.

The commit message should explain _why_ the assert is not needed.
Otherwise it looks that you are randomly removing it to get rid of the
warning.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

