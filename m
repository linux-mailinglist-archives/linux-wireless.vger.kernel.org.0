Return-Path: <linux-wireless+bounces-22071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4DAA9CD83
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 17:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F231BC6E56
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBE328DF09;
	Fri, 25 Apr 2025 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j05UV5dP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2205218C03F
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595978; cv=none; b=dT/MQ1OZ/iBoHiJdYxhUSAEcpP0kPYiyJqb2Lm21bQEAXhDbU7BvRGanBvzljvPjNgrS+JBo1HJDizIozigjRrNeHYY0PCGRJSTojHwLXSwGtrrhWlnBsahOC/gIYUAqz9ZDTsXVYP8aX6JmWvJm+9lxaXhBduOBouqIkcZhZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595978; c=relaxed/simple;
	bh=OEN/M7xAkfDtjvNwKlr/jucG4cQOWcjtHRGd69J9SGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coRuE16pWxdhFqzaADfvO8kBEb0c4ZTPeq8y444pxv9lSSa+auNIUzPIi4FP6f8zMmc+CbZriwKN45zagFdplSkat7hJGZ1EBjaOl1ohq+ZzO5bNZpJMq7UD+0SiaHEukEj3WLhICKGBIQ8huC4c2q5qIQDQimqsyqNiUiEHWGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j05UV5dP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7398d65476eso2039561b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745595976; x=1746200776; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b0yjiKObWEJiwO02DaOrPmXbmFq+eaftYKKT34xnJk0=;
        b=j05UV5dPOBy43iHV+sWZT+yAPem7J7c/EFHZyA9g/WbDbkdHA4L4U5mlWTvXyZ/pya
         1KZJEJJM8+mH1KufUe/KDFW17zAkJGGDWvnFdxr/+IdzMlfmg5rBFAfZppMbD+pPs9yq
         SAfquee+kxH36o3IUKPzBN/PKsk66fQnTs8ouVt0hYQXar0wscnL7c+zFIrOgInHwI47
         ImAPwxXq8Vj0/1RdLNd8DkqhtEZ4UrDL0MKceZzGhd3rnQfEMWKIoFYF/bhPuhYyOK7v
         2GB9WWtKRTUxIOGhVnuVdqzrkCR4ab6v+RC47jbQWN2hoxuAdbFyqMcGs6N3jJHUEt9Z
         wVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745595976; x=1746200776;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0yjiKObWEJiwO02DaOrPmXbmFq+eaftYKKT34xnJk0=;
        b=fOkQ5iSfoW1QoIxZPcq8BBthXvPpAx4J9leDf9J4PD0TJoZ2DTvZq7aYvHedTSppX5
         vTgfLUnsKAkZHeSy4pRuHgefONaeOskQySxghYXzz20TxDkNrQ5+AUqiZS6gTjXx1F2Q
         lHskysPILajrlZn9wrudkBrvYXBJLhhiRJhxE12Qc41QpeaQ65/KHSbUlB7t9DH1Pqme
         rEHAJKNEzvCUYrpLex+VDy0D5jx/Hl9emH7OzsGDzR8LsjZnUEXStyfRVYaS+vw0EFqs
         uVak1yAuPtg0WoQ5d2VIN8J7k2b7aPkaLWy27axvO4ILQ0Xh9H2l7FKjjPc5nX0sZgrT
         pOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnjJ8j77gt26TivN4r4v3v18lhzJvlq6T12pqyNeQZLrR/thF2PED/6k32YW1+jxzNsIhW2TTJfm7Z9+NJzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFv4WpTc9u+Bg3ZZp/gRlExlYn6X5id69y5XD3q2feDirUGlQg
	O6EP+UP9wDLOQW/Wb6AtCEsujZkOKyrrgMZWDJwB+3X7h+aR42TWabtDjrldGw==
X-Gm-Gg: ASbGnctxUF7N1YPI1Ft4i1DJ8J6meDGqQsCpGWTKVcGspbxb6pEXYQ75KkgVOPQ24Y3
	nQORkGygRg2pi6SjExnxeGYe67DFcn/agjCYN72ssV8aDB2lkhajV1MtA9ie0kttZW7xWnZzJJF
	iV6bxRiiH2yRPxnYCEc/cs0+dSsO3/DeGjSG+Nt721LgUChZHY7pyIaPG3PozgRaC8jzB464/zW
	2kJbv6/xtdGDi1TcrFrE3JEvBlnXBOYpkqHl26RuDzQ84qP90O0yzMhD8dotetejtOf4TPn5keD
	OJLSwVNRlXxjLICXB8a0JeDH80Ge6dC2unUoKnBKWqnuWJHqLdv9
X-Google-Smtp-Source: AGHT+IGs6qXZbOiWmzBGdrbn2GeizUSvYWBYF7LQu+E/gHowSvXPMU/F/cIhQAuYikQ05w1s5IHkLg==
X-Received: by 2002:a05:6a00:e1b:b0:736:b3cb:5db with SMTP id d2e1a72fcca58-73e268ee7b6mr11186888b3a.11.1745595976351;
        Fri, 25 Apr 2025 08:46:16 -0700 (PDT)
Received: from thinkpad ([120.56.201.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25967608sm3316408b3a.81.2025.04.25.08.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 08:46:15 -0700 (PDT)
Date: Fri, 25 Apr 2025 21:16:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, quic_pyarlaga@quicinc.com, 
	quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 01/10] PCI: update current bus speed as part of
 pci_bus_add_devices()
Message-ID: <azxdhgvf6vo6eilmdmxa2ryir33h5uqwuru2a7jrgjuunyncrb@q3fdjhcaskjm>
References: <20250313-mhi_bw_up-v2-1-869ca32170bf@oss.qualcomm.com>
 <20250313170001.GA738398@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313170001.GA738398@bhelgaas>

On Thu, Mar 13, 2025 at 12:00:01PM -0500, Bjorn Helgaas wrote:
> [+cc Bartosz since this is related to pwrctrl]
> 
> On Thu, Mar 13, 2025 at 05:10:08PM +0530, Krishna Chaitanya Chundru wrote:
> > If the link is not up till the pwrctl drivers enable power to endpoints
> > then cur_bus_speed will not be updated with correct speed.
> > 
> > As part of rescan, pci_bus_add_devices() will be called and as part of
> > it update the link bus speed.
> > 
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > ---
> >  drivers/pci/bus.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 98910bc0fcc4..994879071d4c 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -432,6 +432,9 @@ void pci_bus_add_devices(const struct pci_bus *bus)
> >  	struct pci_dev *dev;
> >  	struct pci_bus *child;
> >  
> > +	if (bus->self)
> > +		pcie_update_link_speed((struct pci_bus *)bus);
> 
> Why the cast?  I guess to discard "const"?  I would prefer to avoid
> that if we can.
> 
> The only existing callers of pcie_update_link_speed() are from bwctrl,
> where it obviously makes sense because bwctrl manages link speed, and
> from pci_set_bus_speed() in the pci_alloc_child_bus() path.
> 
> If we call pcie_update_link_speed() here, do we still need the
> pci_set_bus_speed() in pci_alloc_child_bus()?
> 
> Bartosz, so you have any suggestions?  Is there a point in pwrctrl
> where it would make sense to do this, similar to what bwctrl does?
> 

I'm not Bartosz, but I could speak for pwrctrl.

This should really be part of pci_pwrctrl_notify() in pwrctrl driver. Pwrctrl
driver is already getting notified with device additions and removals. So the
update can be performed once the device addition happens.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

