Return-Path: <linux-wireless+bounces-20705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EA0A6CD06
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 23:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B17189A426
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 22:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE281BD9C6;
	Sat, 22 Mar 2025 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtGN1GCl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE65114386D;
	Sat, 22 Mar 2025 22:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742683904; cv=none; b=nGD0zCxy9tSbSS7stZJtql3d8PlQTjR8qTQy0Q+RcwemetPPNJlCoxgtn0Y1QcaycQplg6Hi/ilLxNgucnqNN/3p1H47XNGMeWineNnyx9JA2qVDv6O/GyUF5p6ZvQE3H6T6HYacHbD2hvPaJhW4kQUwTEmp2R5z/m8PqRLXk0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742683904; c=relaxed/simple;
	bh=/T6fIJ/31Cw18UV0ZROcFTr6Z4CwQrGMBwrIiprMO+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLwpA/B5bVPTHuwh72fP0RO/TFKjCGWiznxdhIlwmC7rfLJgM+cAjZEWQchq6A19k5o56BVBxXlHaDOsAlmUIvuACTti+oaX+zAB3pol+H/twGwhtGXUYvznitdXX4nHpoSUOLdyIm4RtTDL8e7N3PorrGthcqkhkABZM0Q/6NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtGN1GCl; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39149bccb69so2915393f8f.2;
        Sat, 22 Mar 2025 15:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742683899; x=1743288699; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Jt14YxismGrzSFIUTNtRc9HQQUaY0k4x/qsI+lQ69o=;
        b=UtGN1GCl0GgpDDv2imRIzoq3eV74def9Dko9lyLIrqGYOrIA5mIwniFtI6QMHSgr8H
         95QLvGdbsVh4mm1Wj6CNHkWgNMylr3H+d63kK2+XPjQLO7gl7gcG/gEnCgOVowhsp0X6
         zN/+MCRQ90CgOwRCJx6MSXw/zOdt30RuultqQcPtdndvNbP2ND6JxidByQN8NTAZ+WWH
         tZK45EgvJlj6afMYDti6EzpGjAI7UKqu+BrxPvIn1WlciIMLWEVYf9axDFIcoubYJi3K
         ikIJKZQ8FTeoAvxVJHPFRnNItgWbDYDDTv6t3hlDb6O9hfY671Fb1nuJ4bUyKX1wqJH/
         gVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742683899; x=1743288699;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Jt14YxismGrzSFIUTNtRc9HQQUaY0k4x/qsI+lQ69o=;
        b=KyXgfxwJ91RLlf4FloSuEI5uhdZJbB8E0FggCVKkkxeyLi8H/dvOMLASzbi+Q21Aey
         jUMRA79IPYWnYFasUB+HBnUwpEaUX2j/twdNr430Sf5KBcSaqZwSTQUE+00fdsvv6oIJ
         p1HIEy6Q8U65QeHkmhlX5ZwyWH22ZNZviOypPvK8u2ZnkibvQTdlQqXp037ZHyKOoxm5
         1J+/41dMsv2wNVcQTFQEcOHfwMQYDDjEMWzZ8363c2QrTJfNWqQWYlFYI2ckZ0JniZv2
         SDPE2680qr4bW5P0Jtm+gNS3SS8QCdAH/3wPAWEJl7gO025Ub26gNgxi55uEG8HHO+hH
         OSQA==
X-Forwarded-Encrypted: i=1; AJvYcCXDVDL2noIRSmyEnPUjk49KxO+P76GbhpYxV5iiRaAWDSn6KNT66O789bVjjX9AFTq2zWqR9XnS44j2FyM=@vger.kernel.org, AJvYcCXc6fXkrw9N0j9h4k6rrLDbeMGYfwykjDu1i+cw2Y9LuYlvtcjCmTPzvmhwfHOqBbrDl/PDoGdDpAChnrEgGVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeHP0eVA1vb/KXIVDiH0p0r+850gRjgYiZ3R1qb0DOyybTA9pp
	DKaGMn5AKriPmu6UbJHUp66wR1inz43E/aEepjBZQp1sJJToODBg
X-Gm-Gg: ASbGnctwmVYf/Yj0PXg8p4vG8YsYJVRGM5XLoObTzcTlzwTPYyos3NKdEJS9dB6TKlt
	puaqk/qb0T2DT7VkjyjdZS1paAH3mV899hDw/yGIZhOX4ySIecPEFOHaGYzqrjkxaUQ9tVEd7MR
	QmNREzwhVXcQsHPifA3c+lri6ZGnHqyl4GWtCFtZKpTVzAT2C0UiQ3HMccETmNwpzkjQt8RT6js
	3nKiW9QNkRqp8RGddCbOsf8XViXVg99JCTzpZBRZkjesMtjSlyz/Em/A4TgsXdmExsOdzAnMTYH
	Y/KJyoY0bSk1e+OYuf5KUiP1pq7fmWNDeB+haWoywttYsJbq
X-Google-Smtp-Source: AGHT+IGxXIu9gFWA5FTHPGshtlN1jdaNgj6n+gV081Jt+w3afTixlCPB5LoK8q8g2bwFmjRD4hWrlA==
X-Received: by 2002:a05:6000:1547:b0:391:2d61:4542 with SMTP id ffacd0b85a97d-3997f8f2855mr7155076f8f.11.1742683898800;
        Sat, 22 Mar 2025 15:51:38 -0700 (PDT)
Received: from qasdev.system ([2a02:c7c:6696:8300:ec99:3da1:428d:90b1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9eef37sm6054754f8f.85.2025.03.22.15.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 15:51:38 -0700 (PDT)
Date: Sat, 22 Mar 2025 22:51:22 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
	shayne.chen@mediatek.com, sean.wang@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com, Bo.Jiao@mediatek.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7996: prevent uninit return in
 mt7996_mac_sta_add_links
Message-ID: <Z98-6kXoYdSaFtVR@qasdev.system>
References: <20250320201914.48159-1-qasdev00@gmail.com>
 <CAOiHx==UCeMQpywQJCLPQqipEW0tK9youRxdR5+_T1LuGp_EHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx==UCeMQpywQJCLPQqipEW0tK9youRxdR5+_T1LuGp_EHA@mail.gmail.com>

On Sat, Mar 22, 2025 at 12:51:57PM +0100, Jonas Gorski wrote:
> Hi,
> 
> On Thu, Mar 20, 2025 at 9:19 PM Qasim Ijaz <qasdev00@gmail.com> wrote:
> >
> > If link_conf_dereference_protected() or mt7996_vif_link()
> > or link_sta_dereference_protected() fail the code jumps to
> > the error_unlink label and returns ret which is uninitialised.
> >
> > Fix this by setting err before jumping to error_unlink.
> >
> > Fixes: c7e4fc362443 ("wifi: mt76: mt7996: Update mt7996_mcu_add_sta to MLO support")
> > Fixes: dd82a9e02c05 ("wifi: mt76: mt7996: Rely on mt7996_sta_link in sta_add/sta_remove callbacks")
> > Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt7996/main.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> > index 91c64e3a0860..78f7f1fc867e 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> > @@ -998,16 +998,22 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
> >                         continue;
> >
> >                 link_conf = link_conf_dereference_protected(vif, link_id);
> > -               if (!link_conf)
> > +               if (!link_conf) {
> > +                       err = -EINVAL;
> >                         goto error_unlink;
> > +               }
> >
> >                 link = mt7996_vif_link(dev, vif, link_id);
> > -               if (!link)
> > +               if (!link) {
> > +                       err = -EINVAL;
> >                         goto error_unlink;
> > +               }
> >
> >                 link_sta = link_sta_dereference_protected(sta, link_id);
> > -               if (!link_sta)
> > +               if (!link_sta) {
> > +                       err = -EINVAL
> 
> You are missing a semicolon at the end of the line.
> 

Good spot! not sure how that happened but I will resend a v2 patch.

> To also do some bike shedding, you could initialize err (with 0 or
> -EINVAL), and then change the err return to return err ? : -EINVAL;.
> But your way has an explicit error code assigned to each failure, even
> if it is always the same. So I won't claim my suggestion is better.
> 

Thanks for the suggestion, I think this could work however I think my 
current approach is more a bit more readable, so I will leave it as is.

Thanks,
Qasim

> Best regards,
> Jonas

