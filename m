Return-Path: <linux-wireless+bounces-11433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50237951DCE
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 16:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3A8281E6D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE63D1B375F;
	Wed, 14 Aug 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Hd5UJhd2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9491B3758
	for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647310; cv=none; b=bRKjdGEGT+9YLGs3rNQfIQBml5WpVDCvZQoy3WjepUX0Jc3QZdL456qqCA839aKKxV8jQtTAj37Rcj/2vp+DT32/IRhWBuVnuZe9LV5NSFiKQ11tGX6jRI+3iC0poMxQit8COcd+A7n4iqJZlz7nhA2xl4XgeLZbz35UHs9jDsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647310; c=relaxed/simple;
	bh=dJldu5VxlOMsKibIU9y+RJqlI9VGg6MpvpzqwU/xkms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcSXCYeDvwOExYnQ/q3sJPEGyUShDK0wg4IMPU+7dRqo09lik/fE/SXEDb04Lv+stv6fZ8Z+TI/sKwxNIn4TMrdQwjauMtQ5t8Q2RNFajgq1rqim3qeiR0bl8hKFl2wjnnliIlpS3B6NwhwHV25WBv1bf6iy6uivzbRY4BpoqtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Hd5UJhd2; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44feaa08040so37676611cf.2
        for <linux-wireless@vger.kernel.org>; Wed, 14 Aug 2024 07:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1723647308; x=1724252108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=paVxfT7JAmu1fNgkpHnI3za7LGAbCzSYFrg+0MArE5k=;
        b=Hd5UJhd2bsJnTtj3YalP4r89YXqm/NC+A5FT9nYusOUbPuRRe8zqixA0cABahUYuBG
         Dc/xoprkTrJFTHkeT1AZa2mn3BYBd7LxW6n1R+Ql6e9RRCJHxjylqhzGqb77BnJNNK+d
         dHrq1O/Xl+cc7vRmxcQlzVXMhTtUWBx78dD8UkQTTAisapieZtXTuZj5fhDxu9GaP1en
         nhM+6r1Ajf2E9CqsXfEthWU8NYxGx4f9HugLTJnZTYdpcg6J7xc9OCAWAGyoSJbOm4YA
         pnPKuT9YARtMj6ops5FGfhcfyoHyUxgzM25M39Rw69xSG4fYqidLOLh2TG7XvK5XiXSy
         IBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647308; x=1724252108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paVxfT7JAmu1fNgkpHnI3za7LGAbCzSYFrg+0MArE5k=;
        b=RQ6ITVcxnk9b5JJxwICxaP20WuBZ0KTZag5GCknLC12FeTjB1iJDKJw6ZkSZJwfMsY
         Lm8egsJ4wmEub6JoitusAsXkGzLtAc4Ri4FGyTTwNg5P8m317NB0BA5oPaoYB1vYvG5y
         dVZoYwsMvVSCtXfWIdyww7NZMv7tj5s3AaCDdpzVertd4yX3wef7FLDfPDzQLsqIr+cQ
         IGL0hAm/54S5V1ihmqQIbERVKOuYxGz8vGIMByztoKgOD09pzPSwKF4JVluSIalBp1Q0
         0nmD+4mEOw9+UrQMifcrmrs/WigRRk9hNHXC2V1yXmLD5+PO2LNwudC1KqMaMXA+mn2G
         G6YA==
X-Forwarded-Encrypted: i=1; AJvYcCU1AdA0QSAbqbJcJJilU+0GB4xzmrET/1i/UeKcbm9WW6B0xJv+1fwk7Le62hO8hSBsk2UJ8SjZvDiSiptbTkFFZhNKY3B1oXc0DVFWYPg=
X-Gm-Message-State: AOJu0YwCD3KRC6SGr3LUaH4d/pMbaHIqaOk/xfMV1SBG/h8CZMxqixIJ
	5ig6x2g8w5WjQVl0AHwVD3PvfYPW7fKwtWSKFHq8JTS97WPiodrc+4OsTwCzaA==
X-Google-Smtp-Source: AGHT+IEPPGP9QdTJ1Avwn+UZGpIsackRhw1IDAbi9HBSW75uOnXFPE0pnGcbbi/cRNJv5qir2DhHdg==
X-Received: by 2002:a05:622a:4a87:b0:44f:f11a:63bf with SMTP id d75a77b69052e-4535bb9fefemr39748221cf.41.1723647308072;
        Wed, 14 Aug 2024 07:55:08 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-24.harvard-secure.wrls.harvard.edu. [65.112.8.24])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45333cd5babsm30465031cf.22.2024.08.14.07.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:55:07 -0700 (PDT)
Date: Wed, 14 Aug 2024 10:55:04 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: LidongLI <wirelessdonghack@gmail.com>
Cc: gregkh@linuxfoundation.org, kvalo@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, mark.esler@canonical.com,
	stf_xl@wp.pl, tytso@mit.edu
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer
 Dereference&Use-After-Free Vulnerability
Message-ID: <91e19cf3-216b-48ac-a93d-f920dd2a7668@rowland.harvard.edu>
References: <2024080359-getaway-concave-623e@gregkh>
 <20240814055816.2786467-1-wirelessdonghack@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814055816.2786467-1-wirelessdonghack@gmail.com>

On Wed, Aug 14, 2024 at 01:58:16PM +0800, LidongLI wrote:
> 
> Dear 
> 
> 
> 
> When will the patch be released? We are waiting to test it.

Sorry it's taking so long.  I have been extremely busy with other things 
during the last few weeks and have not had any time to work on this.

Alan Stern

