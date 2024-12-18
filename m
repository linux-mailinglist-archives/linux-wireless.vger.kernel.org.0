Return-Path: <linux-wireless+bounces-16545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1BB9F6B79
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 17:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14499188B6B6
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 16:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DF61F8AD4;
	Wed, 18 Dec 2024 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOdJ7aSI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C7E13B58F;
	Wed, 18 Dec 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734540621; cv=none; b=mCVL5AQdFEP4/GKjTDGxw4BnJDeQCtmmiOjMgwf8OcVvnsPJrT+oS25SN+9kPYZGzVfn60zyqPHUyn6dOYkzL+oNil7IbKRgiz9/K17ig9fCtd0CH7Iic+8ezl5gQARwaagt3HaSylcnfRFVmMgRCFwtzqb5V3FHl6/wCUkaMnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734540621; c=relaxed/simple;
	bh=7+necGPxSGo7sMtURcZ9mr0EJGBKL6/Ke2PfFK9/UYo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BulO0rY6uNmkhCgg/eANhCEe5/5oSndjLrZfc1H0TrYBAAwSQrWyMjhqsdjQ49NGBq/0qN6LlJnUlSuQ+FoLSYTjaR/9txXeg/rkqsj6MwQfmzyjV3TRDd0dG92OoB3Jsu0Q8+KPcfwLO0AWoUge6mY2O6c9oJcTJb96/iG6zio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOdJ7aSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD982C4CECD;
	Wed, 18 Dec 2024 16:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734540619;
	bh=7+necGPxSGo7sMtURcZ9mr0EJGBKL6/Ke2PfFK9/UYo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=bOdJ7aSIvMGvhWqdSvt9YcvP/9FVRUvb/N5+4/0bk6m3uUebuHuu1eAP1VehihuiW
	 nBoGMeZZaTorFNXpS3qRHEVsUQ2DMCRLAZzbjy/KgJrtWURMSX7+GGn5JsyiZo0CCF
	 HYqF7pIKWvI0qy//RNV7foJP5E8hdgcHsb+z4/x1ErnDHHtcCYK5Mk3zKbh0P/TzH/
	 z35oD28CrpW3EZGZtexUev4/VeXcu61OsJrZOQ8iGNrDUXVdEnAWuKUlYpGz65HEv3
	 DFzdhM+QC1pGw9AdbM9ngR5FXM/Mzuow6kuJK6gesSqEa861dgjMXwnydNKZaI6Ctt
	 P52X7QKOZsYRw==
From: Kalle Valo <kvalo@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: WangYuli <wangyuli@uniontech.com>,  <nbd@nbd.name>,
  <lorenzo@kernel.org>,  <ryder.lee@mediatek.com>,
  <shayne.chen@mediatek.com>,  <sean.wang@mediatek.com>,
  <matthias.bgg@gmail.com>,  <angelogioacchino.delregno@collabora.com>,
  <davem@davemloft.net>,  <andrew+netdev@lunn.ch>,  <edumazet@google.com>,
  <kuba@kernel.org>,  <pabeni@redhat.com>,  <alexander.deucher@amd.com>,
  <gregkh@linuxfoundation.org>,  <rodrigo.vivi@intel.com>,
  <linux-wireless@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-arm-kernel@lists.infradead.org>,
  <linux-mediatek@lists.infradead.org>,  <raoxu@uniontech.com>,
  <guanwentao@uniontech.com>,  <zhanjun@uniontech.com>,
  <cug_yangyuancong@hotmail.com>,  <lorenzo.bianconi@redhat.com>,
  <kvalo@codeaurora.org>,  <sidhayn@gmail.com>,
  <lorenzo.bianconi83@gmail.com>,  <sgruszka@redhat.com>,
  <keescook@chromium.org>,  <markus.theil@tu-ilmenau.de>,
  <gustavoars@kernel.org>,  <stf_xl@wp.pl>,  <romain.perier@gmail.com>,
  <apais@linux.microsoft.com>,  <mrkiko.rs@gmail.com>,
  <oliver@neukum.org>,  <woojung.huh@microchip.com>,
  <helmut.schaa@googlemail.com>,  <mailhol.vincent@wanadoo.fr>,
  <dokyungs@yonsei.ac.kr>,  <deren.wu@mediatek.com>,
  <daniel@makrotopia.org>,  <sujuan.chen@mediatek.com>,
  <mikhail.v.gavrilov@gmail.com>,  <stern@rowland.harvard.edu>,
  <linux-usb@vger.kernel.org>,  <leitao@debian.org>,  <dsahern@kernel.org>,
  <weiwan@google.com>,  <netdev@vger.kernel.org>,  <horms@kernel.org>,
  <andrew@lunn.ch>,  <leit@fb.com>,  <wang.zhao@mediatek.com>,
  <chui-hao.chiu@mediatek.com>,  <lynxis@fe80.eu>,
  <mingyen.hsieh@mediatek.com>,  <yn.chen@mediatek.com>,
  <quan.zhou@mediatek.com>,  <dzm91@hust.edu.cn>,  <gch981213@gmail.com>,
  <git@qrsnap.io>,  <jiefeng_li@hust.edu.cn>,  <nelson.yu@mediatek.com>,
  <rong.yan@mediatek.com>,  <Bo.Jiao@mediatek.com>,
  <StanleyYP.Wang@mediatek.com>
Subject: Re: [RESEND. PATCH] mt76: mt76u_vendor_request: Do not print error
 messages when -EPROTO
References: <1E6ABDEA91ADAB1A+20241218090833.140045-1-wangyuli@uniontech.com>
	<a2bbdfb4-19ed-461e-a14b-e91a5636cc77@intel.com>
Date: Wed, 18 Dec 2024 18:50:05 +0200
In-Reply-To: <a2bbdfb4-19ed-461e-a14b-e91a5636cc77@intel.com> (Alexander
	Lobakin's message of "Wed, 18 Dec 2024 17:10:53 +0100")
Message-ID: <875xnhrl4y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> From: Wangyuli <wangyuli@uniontech.com>
> Date: Wed, 18 Dec 2024 17:08:33 +0800
>
>> [RESEND. PATCH] mt76: mt76u_vendor_request: Do not print error messages when -EPROTO
>
> Is it a fix or an improvement?
> You need to specify the target tree, either 'PATCH net' (fixes) or
> 'PATCH net-next' (improvements).

Actually this is a wireless driver so the options are either wireless
tree or Felix' tree (for -next). And please add 'wifi:' to subject.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

