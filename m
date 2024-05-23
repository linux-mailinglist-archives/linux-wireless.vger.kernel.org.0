Return-Path: <linux-wireless+bounces-7968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E288CCA2A
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 02:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B031C21267
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 00:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EEB17F7;
	Thu, 23 May 2024 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HjX8ixgg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B94E17C2
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716425431; cv=none; b=Htr1jedxbb7TmOeqzwfqXWEtLQeMS6xgKuGoXFT7ovNxbqGOpU0X8gWDhMofqumbkWECS8FTl3SjJm0E3aU8VHGTFeZfVS8cAZHCbnRAM/2GkSHDRM4WHQBzajnjdW/PR0UfavOinsoNQF45Han7ArwYYtfBybIZP/ZkS3nQkqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716425431; c=relaxed/simple;
	bh=UbwQHGJBE6SZy3dTvzmiW3Y7u7jPztiPZ4sdWKIuK9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKbSi8bOm0uuXAVPfb2qjZUYclmL+JyeFTbwuKHCBIrz+TKsb0fMPcNfINnEglS9pOnM+wGRIVzxAEBjlu62GNktTsSDJ5yRGc+aJC01OademSEhy6u5HDLH4vQOWLOrIi9/o4ap5Xf5fXiKdiIb230GxPBQ3KpFAVmwcO+8J8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HjX8ixgg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ee12baa01cso15521965ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 22 May 2024 17:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716425429; x=1717030229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/bNuy6SM/kLB6qLCSNaw2T+XxnPO+OsFpO7610Vx//k=;
        b=HjX8ixggKAjeqRU17T6IPgVoQlI7BnR5bE5FnPdqVNcq5gS3kLGTMayAu52XGMxIGs
         IhYPuW7x4Wp8aEId7JTpOckT314Evr4uVSl3mvXqKyQ+dYTq7MUKYATR5gQh48M13iPJ
         gvQpwKYtRKLJP9/S5C41Aa05UOaPnWH3lnjBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716425429; x=1717030229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bNuy6SM/kLB6qLCSNaw2T+XxnPO+OsFpO7610Vx//k=;
        b=F9fkOxlIdt2M6ZDgRQMvyw875r/IJOlp6fvVJkXDldC3l/joaBz1GzBqClLMiC+cAB
         dMeeJp1ejDf+zOhs6FTFFs+1VCPfmL2t6eAIwNFH1AEwEs/UVO+oosV+TRxuDDUPqBBs
         dERrmz1oaOXJXPHcv8W5bmPOx4bhzKdR2WUAi/Iv0xJZZCH8FqH+JPkpd9umasCHx/2S
         CYNxcuvXUcEljb+f+2we/lvTaNcelF78ep8o4RnFucN+/5FDV9lyJL09IQSaRAGFVY23
         ij0yK2ZAdIbs756WGRUARcGiHYw4bFxujEbwwwCIxbzjm3jCFJmkGXPnFy2k2ZTZE3nu
         APtw==
X-Forwarded-Encrypted: i=1; AJvYcCXDHg8l0Zr7XxTbJt0kJyA/QOKwq1bTWOuOuRVo638OjxZKr+MQtTgjg/xofv/Vg2+r2G8OWkbbmxAArBE5rsrztpNjtgzNqymx0HXw/BQ=
X-Gm-Message-State: AOJu0YyHNKskwE7q7bZ3oL9ZbxWPs1jDKrD4Mdo1v2nC1AG5O0V4tgNP
	1c+oM9m1nekuFnSoYurX7Q5EwEfFBc01QuUxzwM/niiIMpJg2CUeb+OvvkLz6A==
X-Google-Smtp-Source: AGHT+IEdMYJvguszZWQhcagUOIsDBSSSsuIKGnskWDfANoYCNYn6AMpeqnKTOXyc04/jjf4/0L64nw==
X-Received: by 2002:a17:902:e944:b0:1f2:f6ca:fbca with SMTP id d9443c01a7336-1f31c976c1emr37161985ad.9.1716425429401;
        Wed, 22 May 2024 17:50:29 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:3a97:1cc8:ab6c:8d0f])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1f326bd5b70sm17699125ad.237.2024.05.22.17.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 17:50:28 -0700 (PDT)
Date: Wed, 22 May 2024 17:50:26 -0700
From: Brian Norris <briannorris@chromium.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"rafael.beims" <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [EXT] [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Message-ID: <Zk6S0m2U_xEojICb@google.com>
References: <6CB59E09-F34E-4986-AA88-8EC4EE5E71DF@holtmann.org>
 <PA4PR04MB9638B62BC25F773C6922A4BCD10D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZiLlPOvKlfCySZwF@google.com>
 <PA4PR04MB96383D46C1187C237DFC7988D1122@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB96389E67F826216C44FE19FFD1112@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <C8F76484-1359-437B-85BF-C646A21F7BCE@holtmann.org>
 <PA4PR04MB9638670FD6768AD8A69F5125D1172@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXNhkHi47=d-TMkjy3oebsK_NvWuC9CQtEEQYN-nHHbx-g@mail.gmail.com>
 <PA4PR04MB9638F35B2FF70A1E514C25D0D1182@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB96381B9675BCA5861AEDEF25D1E22@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB96381B9675BCA5861AEDEF25D1E22@PA4PR04MB9638.eurprd04.prod.outlook.com>

On Mon, May 13, 2024 at 01:27:13AM +0000, David Lin wrote:
> > From: David Lin <yu-hao.lin@nxp.com>
> > Sent: Thursday, May 2, 2024 4:35 PM
> > 
> > 1. The process of external_auth should be as follows:
> >   a. cfg80211_ops.connect() is called to establish connection with remote
> > AP.
> >   b. If authentication is not WLAN_AUTH_SAE, FW will process
> > authentication/association
> >   and reply connection result to cfg80211.
> >   c. If authentication is WLAN_AUTH_SAE, FW should notify driver to call
> >   cfg80211_external_auth_request() to offload authentication to
> > wpa_supplicant.

FWIW, I expect you could just as well teach the driver to detect this --
I don't think we'd strictly require that firmware notify the driver.
Essentially, you could teach the driver to notice any sort of CONNECT
request (e.g., keep a list of FW-supported WLAN_AUTH_* modes?) that the
firmware can't handle on its own, and begin the external_auth() process.

I'm not sure this is ideal, but it does sound doable even without FW
notification.

> >   d. FW will wait for authentication result passed by
> > cfg80211_ops.external_auth() to
> >   decide if association should be processed with remote AP for the original
> > connection
> >   request and reply connection result to cfg80211.
> >   NXP FW only supports association with or without authentication, it can't
> > support external_auth.

But could it support my above description? Basically, the driver decides
whether to submit the connection request directly to the firmware, or
go with external_auth() instead.

> > 2. Hook separating auth/assoc will offload SME to wpa_supplicant
> > completely. Driver/FW don't need
> >   to involve the process of authentication just like external_auth did. There
> > is no effort for driver/FW
> >   to support any future modifications of authentication process.
> 
> Can we confirm that hooking separating auth/assoc is more suitable than "external_auth" for mwifiex?

I have one clarification question above. And I haven't heard anything
more from Marcel, so assuming the above is clarified, I suppose we can
drop the external_auth question.

Brian

