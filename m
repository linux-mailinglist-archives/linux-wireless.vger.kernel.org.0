Return-Path: <linux-wireless+bounces-10897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6323B946E2B
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 11:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D97A7B20EE5
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2A0249ED;
	Sun,  4 Aug 2024 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDiLJOnw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006F323759;
	Sun,  4 Aug 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722765374; cv=none; b=j28JG0uOCj5Uf/AgVSuk2VNXO6ULkoeFZQ+Qaynw1tsJTvkN0x+62jK6gsZDDwaCb+NDT2DZ9IVz60dOj3TYT4RUAxqzSQCG4fz1brDcjIu8BEnixv8xi2kk4WVqNYUjOWfVfbpEvk9BrAwX7yV40ve4yd4rSX+hLOSM1b2LTRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722765374; c=relaxed/simple;
	bh=6GYgW1pBDBnhlAKtizrPp43IWcryMt4Azi1dzXoCvgc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=mtpH7YVs98ef7e/b2FfzSEiI1dB1Xv/Fi+d6hN1loPVxlhiunJLkpKOZiaY/Zg37VUFuW5iTYRNohZ4QrEZWzZcOwKSoFFgOhkf6RJQIAc/f9MWJTCv68qEZ9Ai3+1lP+7HEwP8i11I6MckNKOuu3oGh2R5vB1DJIbyoe7UOoe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDiLJOnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D25C32786;
	Sun,  4 Aug 2024 09:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722765373;
	bh=6GYgW1pBDBnhlAKtizrPp43IWcryMt4Azi1dzXoCvgc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=oDiLJOnwzA0J4o0OpLS6Q0pkgt/1WpuYclKUFXXJHLAwMsSp+GfesATO+Mg0DwIUU
	 mncuCeSX1ffvQ0SFplZhTAyQq/9ivBchR7ZZkQ8D5orkq+MYOvQaqgFIHsom9vSinV
	 7RR/QDDCemM+0blfVkS/DHE4HEv0vZBDzSiYA9SyFlCt6ZiIzLtGejwlGx8iU/9b6W
	 jDhLIq4ZFZnjGwZxWL67wAHXMZ4zUMfY+unU94Qc8rXQuNr+Mxxcpy8DbHawHU3KZ2
	 JPgG9cLXr8fvFsfV+RmBusS9ziPscrH9qo3leD7VK1Cxe9QAzph40WdBoGmEEd5GNI
	 ZT2AeIGJNvE8Q==
From: Kalle Valo <kvalo@kernel.org>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: kernel test robot <lkp@intel.com>,  nbd@nbd.name,  lorenzo@kernel.org,
  ryder.lee@mediatek.com,  shayne.chen@mediatek.com,
  sean.wang@mediatek.com,  matthias.bgg@gmail.com,
  angelogioacchino.delregno@collabora.com,  chui-hao.chiu@mediatek.com,
  emmanuel.grumbach@intel.com,  StanleyYP.Wang@mediatek.com,
  meichia.chiu@mediatek.com,  johannes.berg@intel.com,
  quic_adisi@quicinc.com,  allen.ye@mediatek.com,  bo.jiao@mediatek.com,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,
  linux-mediatek@lists.infradead.org,  oe-kbuild-all@lists.linux.dev,
  Sujuan Chen <sujuan.chen@mediatek.com>
Subject: Re: [PATCH v5] wifi: mt76: mt7915: add wds support when wed is enabled
References: <TY3P286MB2611CB2F4F5FA27D782AA80A98BC2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
	<202408041039.BqVRJOqp-lkp@intel.com>
	<TY3P286MB2611C363575C77278946A4B498BD2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date: Sun, 04 Aug 2024 12:56:07 +0300
In-Reply-To: <TY3P286MB2611C363575C77278946A4B498BD2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
	(Shengyu Qu's message of "Sun, 4 Aug 2024 17:28:20 +0800")
Message-ID: <87o7687gso.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shengyu Qu <wiagn233@outlook.com> writes:

> This error report is a false warning. "struct mtk_wed_device" needs
> "CONFIG_NET_MEDIATEK_SOC_WED" to be defined.

I didn't investigate anything but based on your description that sounds
wrong. The code should should not be compiled if it depends on
CONFIG_NET_MEDIATEK_SOC_WED but that's not set. We have zero rule for
compilation errors or warnings.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

