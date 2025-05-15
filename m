Return-Path: <linux-wireless+bounces-23038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F50AB913A
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 23:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACB83BE22C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 21:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0A828C868;
	Thu, 15 May 2025 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWdRCgp8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADEF35970;
	Thu, 15 May 2025 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343518; cv=none; b=f8HxWUwO0jHStCxTQjK+8v0Pja1+9snB71+NFjFXnF/KjRJ/RRf7g1+rvBgK97elzdS2RxIViM6a5dk9GED5k9FIg+KFUgwQLTc896LPEjKuVSRS76J989Kp7o+XojNorCb+a7e2pqFQuWTsh7ek1KfhFb6VaeK+b5y10WORfpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343518; c=relaxed/simple;
	bh=at8wo4sideq12LISKVbT5TJ813to55EQj1hiXx40xJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e797WBTMOWvsVkXgwf/aX9fuEIeH9OfOgzbL68Z1Wq1TYCstO1MxokJB4V7zIEZu7PUQrHTRj7MiQnvAO02/rh2v0PbZoE5GqQYuE1sUwfP34J4IB0qgdRNbNJUaefoZiC95m6a4JRkSmw/u3/3GYKAGCRwL73q8K5XTRR/B7dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWdRCgp8; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54e816aeca6so1894189e87.2;
        Thu, 15 May 2025 14:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747343515; x=1747948315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDYhltCq2quiDqrEIIaILKsSX4NxL0nbga+EY2yVcTQ=;
        b=MWdRCgp84DMupgUMO2/73yz/ckAQM8w8myxTl9aVSY7x8wyLOpknWS5qAnjMKMTNU9
         p51W3NkC7p8J/x1sAX/9q63TKwtxjlkfGKiR/MT3Rz8vPj2OdhI/G3jq7rKaWtQSKCAZ
         fzVwb4X8R1epOrTAv6v/gQ6ASD4KjYvEGsOenxc/o3FOLu7HCkaIxGMsrQ+uGV9F5PFj
         H3uEMSBw2BItJGiyvO+zR/iWYWC3uONpg4daN/7dmcV/35Wr9uAWA8/O4J1uxlNl5stt
         blxwf/2vPfFm+wEpM2Xrtjw7TpvsvUOFYHs19MNpW1in/2bXOT7wfiWo/locsm/7X/wu
         Xl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747343515; x=1747948315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDYhltCq2quiDqrEIIaILKsSX4NxL0nbga+EY2yVcTQ=;
        b=MCKzF9BuJAkIsuUDLOcWAjGF81FLOkjOrqhoGIetSOJP2hZF5f8fkpYePLAnRvGc65
         xksIj05Y579DwXa5AyMlxWt562OCyAK+s3j5s+FGOxt0LpNO5BdRpggrmT3ghG5d/ETM
         jNU1xjpZEj7Cze44AvaksiC9SHKGl70gKD8qUDtfNNEbgW1XJLGqVUpUEYg6CaiyDRmH
         X7L4kljHLOqFXih6wQhiRlddJi0uP0MGbk/HY/lQIL4Li6MF8uzDqZAXuTfXMBOentc5
         nPbtx8CbEOThISzuUZ6CBHYqE2u42C/zX8HU4m6DWKmXUBFgTJg721LzyuIOKl4Z8IEu
         Zp3A==
X-Forwarded-Encrypted: i=1; AJvYcCUoXHVrAT/JnAWd7c8a38AjfMG7rYpI85gt7iHuG7+xX0/ugHiVLrWwO11lNY5uu8a5pXUvMdW7PNFi8VQ=@vger.kernel.org, AJvYcCXzDMTKCV7OnAoBqRJk3uzH+1fVePoUEWs9686/nH3yF3uhnQi69acvnT9+iIzn8VkS6uD3/+FjFWbCmGkVQ/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuBQi7g2WAD94Y/ZGQJaPbd6+NkP+6TCaPZ7AOJmY7dLVEfOh7
	ppTdccMyLTGAGZP2kiBeV/NzePEjYDjzIv8Lj2uuHv3dkv4rqYyvrXRVnVdL/Q==
X-Gm-Gg: ASbGncs20V+K/QjuoB6g8G0X1IFvxXoBT7XSZIdskHJvecc7DyTBBaHzOGEpDzj+FGq
	5zKbOGTtgTg26mv91DNRpLAI0wIrkSvaWjlnWUsCFL7D2RQxpI8bSdzJONnp2W5m2x5OCZfZgxU
	3JzgujQ5xITA8W/beIaAyamDG9NomCrD0F2uqUrQugbX5ZiBWOe3fQWixEfobTTnXITojsftx0R
	tXoBcb1Qp6gqQWgwRHkWoXmGbdYIP7g4r5d+RsWeeL801mQQoL81exqJXBtu9WY5DEBB4yezB/G
	+KU7fTYLFQZDQPTFqAKVBw3ilRURksw1iYJj3wfY6a7evzk=
X-Google-Smtp-Source: AGHT+IHCb/STf0vwxoS6kNi3dBUgKys7p8EM3GBFKDOT9iH+gZSWuK48BQSeuyxdMt6uGRIzF0usBQ==
X-Received: by 2002:a05:6512:2616:b0:549:8b24:9894 with SMTP id 2adb3069b0e04-550e71a72bamr248467e87.15.1747343514468;
        Thu, 15 May 2025 14:11:54 -0700 (PDT)
Received: from localhost ([83.149.199.15])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f16354sm103981e87.45.2025.05.15.14.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 14:11:54 -0700 (PDT)
Date: Fri, 16 May 2025 00:11:53 +0300
From: Fedor Pchelkin <boddah8794@gmail.com>
To: Bernie Huang <phhuang@realtek.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Bug report] rtw89: 8852b: IO_PAGE_FAULTs with beacon filter
 feature enabled
Message-ID: <gan5ysjiosyk5il42ifxrzodfgparbw6vod6qboez2mtubbw7s@l7lb3dm7zwi2>
References: <uidltsdsuujrczrtzgerhh5cw2tztxktfen6yvztnc7gttzgvk@jccomj7f4gul>
 <148ed65c53be4ef29246d372dd0fef8e@realtek.com>
 <z54thedngt3wnhr5bfer3yg7id2c4uqgw2jjvyausv6p66ys4k@guqol77fpugz>
 <dcf695a6621f43e38a20eb860194191a@realtek.com>
 <7injzacfmvhrugcovyxkn4elnaxnzg27c26zmcqzrwhottyk7e@ap5ellaozcg4>
 <419811cccd774d38b5a9c0bbcdf5dfbe@realtek.com>
 <42783d9a032143bfb67ea969ee0b805d@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42783d9a032143bfb67ea969ee0b805d@realtek.com>

On Wed, 14. May 03:29, Bernie Huang wrote:
> Hi Fedor,
> 
> Could you please check whether the attached firmware fixes this issue?
> The firmware version should be 1.29.29.9.
> You could check it via command:
> `cat /var/log/kern.log | grep "Firmware version"`

Thanks Bernie, Ping-Ke.

I may confirm there are no IO page faults nor any other regressions seen
on my side with the updated firmware in use.

If needed

Tested-by: Fedor Pchelkin <boddah8794@gmail.com> 

--
Fedor

