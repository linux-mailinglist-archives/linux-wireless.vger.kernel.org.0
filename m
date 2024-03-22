Return-Path: <linux-wireless+bounces-5151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408DD886C92
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 14:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D45CB22EB8
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 13:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3F94AEE1;
	Fri, 22 Mar 2024 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inside-m2m.de header.i=@inside-m2m.de header.b="UrTP3VM6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.inside-m2m.de (mail.inside-m2m.de [188.68.57.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EDD487A7
	for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.57.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112691; cv=none; b=N87BiRibwf+rSOKmQW0mV49I36CW5QQLfb/vcdxnR6MopvCzz4Uxt8UZS4t/M41jASQlzwcLocflaUTdcezRw6F34kqqVhsTsboy6V4PTTVMQzjKebBpfrCsGrLSaYFiGrWKkyL2/36R/aysF2rEB+eIazvBQQPra2angl+Pirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112691; c=relaxed/simple;
	bh=SdPNEsUv4uHhEm2dDPAPNewB7RTw3yRNh+MXOY0S0yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8VbAVWwenGXlinwBO2eTys5Kdky9h2YtfRzgdkE4DmAAxvTYh35fzQRE9yaaBDOWhfMoVuHMdBqguMCT8+4CRTHAh0wMH4Ltu8oq391y+Ag91DAtUs9Snx+rV4WI1P4ZcSOQB2Id9RNVIAXxez0npg4rf/snY6mucfbW2FBTnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inside-m2m.de; spf=pass smtp.mailfrom=inside-m2m.de; dkim=pass (2048-bit key) header.d=inside-m2m.de header.i=@inside-m2m.de header.b=UrTP3VM6; arc=none smtp.client-ip=188.68.57.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inside-m2m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inside-m2m.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=inside-m2m.de;
	s=default; t=1711112678;
	bh=SdPNEsUv4uHhEm2dDPAPNewB7RTw3yRNh+MXOY0S0yQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UrTP3VM6l7pf3INETDQ5keQMSXBrJXlOd/u01hAtA0uO2ACQ6MYB4+Ev5NnXHItb/
	 2LxyVM0P5nomlqdTk38j1lgHFjqRf7Dcq0YV3G16Seq3u47lv5Kt5weE86ZvveNhPi
	 qFJIVq065PE50ceofSOt0v0+GVwRO2gybDMUy6jvjNUt/ylF/zUPZxd5WK/kq6e0ds
	 YetILa1SiNlN1x0IJHPRdHZ5Shq+C/SKAONwT97OB2c6L1xgeCeqjp6JVtBtpdaKg9
	 +lGx/N0eitL13DJMIQnV8Tj8e22GqOyZmgdqxTVKHVVp6YtjVQSMb+ggruqQ8FN250
	 pJxwqo+iRrk6g==
Received: from hephaistos.home (unknown [94.31.104.219])
	(Authenticated sender: konstantin.kletschke@inside-m2m.de)
	by mail.inside-m2m.de (Postfix) with ESMTPSA id 6566B4018A;
	Fri, 22 Mar 2024 14:04:38 +0100 (CET)
Date: Fri, 22 Mar 2024 14:04:37 +0100
From: Konstantin Kletschke <konstantin.kletschke@inside-m2m.de>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: AP mode on RTW88 8821cs
Message-ID: <Zf2B5QZg_duHxWqn@hephaistos.home>
References: <ZfwSM0paZg23iEPS@hephaistos.inside-m2m.de>
 <be67119238e14fa09b3d9dc848d8edd9@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be67119238e14fa09b3d9dc848d8edd9@realtek.com>

Dear Ping-Ke,

On Fri, Mar 22, 2024 at 12:16:14AM +0000, Ping-Ke Shih wrote:

> We had similar discussion before [1]. I think Martin will take his time to
> investigate how to enable AP mode on SDIO WiFi cards.
> 
> [1] https://lore.kernel.org/linux-wireless/36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in/

many thanks for letting me now, I did not find this with my google fu
initially so I am aware now this is known.

If there is anything I could provide, anybody let me know. 
We have the hardware and compiler(s) :-)

Regards
Konstantin


