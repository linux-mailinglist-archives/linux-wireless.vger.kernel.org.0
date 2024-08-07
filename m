Return-Path: <linux-wireless+bounces-11081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8BC94A713
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 13:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B58EB237CE
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 11:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693691E2863;
	Wed,  7 Aug 2024 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBg+5xhM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E3A1DF69A
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723030761; cv=none; b=DLmxsNq0LGV/lk1u4qgh5lKh5eEVHlQMFZTjnpfISpiy4z9HPvjpRhVhd86tVan+x5tKd06lD3sibOSHBC5IbKHRudtdY8rx1G7Kr2gvwVY58ySbiFykt1ng7RI5YQcvW92PfpwjiCV3wUFj4N6dY35r4BbL9JvkmBTxo+m3OdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723030761; c=relaxed/simple;
	bh=Dhr3h+oklaBA8hjgno/SaZcjPJ8+9JMssBSDUQ2p878=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmsXFzp9BGx3QfuG0J400LXQcP3f8OjDnClrxRJHZkHQRf9lOICiiHrGcl06io7zCegE9q4h1R2CU14mjP6wr1eVfo5yzGwT0XAAwmj6cwFFqp1kkE3I8G77cvIPiC+/tWTwsJy5eHs7pmrgCcqmL/HzBo9KeUazhsC4auIYcg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBg+5xhM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723030758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5S7xIbSbjmLQrN3ZIyMbc2A3F+RtNTgafiZdzQ8yuo8=;
	b=fBg+5xhMNKZSwZs6CwXLeaTUu9ozV/coDlgURHFIGoRqpqbDmryjfR2Hsha+fkFbVVODO2
	yRRJGsrlSpoRzHA9tJl4v1V8mhzQxF8WyjmAdP7VwD6nytbeNt6gFlZOPNUzxfU5Ht96FE
	5O8huREFoOwlGlrrqazFo8/kG0+eA9A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-U_lXVfatPFGCAf9WE5SZqQ-1; Wed, 07 Aug 2024 07:39:17 -0400
X-MC-Unique: U_lXVfatPFGCAf9WE5SZqQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42809eb7b99so4564725e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2024 04:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723030756; x=1723635556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5S7xIbSbjmLQrN3ZIyMbc2A3F+RtNTgafiZdzQ8yuo8=;
        b=CjQYTSJtZ7Q5RELhUZsJGAfOtf8T0XCSmRqTheVtuhZnjz9wm3G2yEnhpS5L+a4hWx
         Rq0jKcCNyxIZ+BWID3ZvTf3kS7HLv03epyS6oB0AW1ZexUiS7e0QwpFt7SpmlWHpeJS0
         VDqSFsOwSiIPgeNvDicgUvlLNTbSafFqsUe6uYsPmm58TmzA+RQCl6My2FiLV8cGRkVm
         wKjYIbdlvUraIWYmlkceDUi244XwgmAPSi7TLjvKbItGt/3I8s6/CsXz3BiFsxAXI2bE
         FOvDDkG8j26nsR/slpXBFJW8qbTPcTOP17pwikgTgOoHPQNIHAZd3sIeP1XBOpvEf4A4
         LqXg==
X-Forwarded-Encrypted: i=1; AJvYcCVlj82FboAAqcCjndj+G37RfBMjQ4Lk6g9c1NTX6QDqJEf3rWMkFgd9Bcl4IGAAipP0nuukSYSP+wVmo1GEluH2Goa7BOE0no36InS8vJo=
X-Gm-Message-State: AOJu0YxNyJeyxAhw/WbZsCjWJdpdrANi2djl1G/0P2BGQssudpuOrX+J
	hV6L9VTDNhIJjd0VXhgsjXAqTrStLnlhhOvJO0ytha0f9LEDvzlrNPBXr0VnHnSK/KtwpHd0MYu
	KlsVDmf4gz16v2FGW3xH19sHFcTit47zQJx2GSywd2VuI2tfrf0DZlWPIKuo55+54
X-Received: by 2002:a05:600c:3b0a:b0:428:e820:37dc with SMTP id 5b1f17b1804b1-429050c89d6mr14574555e9.7.1723030756441;
        Wed, 07 Aug 2024 04:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFklACx+3IMygHGRA0VycboRHfK6J5n7H+H6JoVNd5OcTlO8tJgAb5+09LYCAuJsMNV8sTyJg==
X-Received: by 2002:a05:600c:3b0a:b0:428:e820:37dc with SMTP id 5b1f17b1804b1-429050c89d6mr14574125e9.7.1723030755505;
        Wed, 07 Aug 2024 04:39:15 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059cbfaesm23154735e9.42.2024.08.07.04.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:39:15 -0700 (PDT)
Date: Wed, 7 Aug 2024 13:39:12 +0200
From: Guillaume Nault <gnault@redhat.com>
To: hhorace <hhoracehsu@gmail.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvalo@kernel.org, horms@kernel.org, idosch@nvidia.com
Subject: Re: [PATCH wireless-next v2] wifi: cfg80211: fix bug of mapping AF3x
 to incorrect User Priority
Message-ID: <ZrNc4FHH8I3VD0io@debian>
References: <20240805071743.2112-1-hhoracehsu@gmail.com>
 <20240807082205.1369-1-hhoracehsu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807082205.1369-1-hhoracehsu@gmail.com>

On Wed, Aug 07, 2024 at 04:22:05PM +0800, hhorace wrote:
> According to RFC8325 4.3, Multimedia Streaming: AF31(011010, 26),
> AF32(011100, 28), AF33(011110, 30) maps to User Priority = 4
> and AC_VI (Video).
> 
> However, the original code remain the default three Most Significant
> Bits (MSBs) of the DSCP, which makes AF3x map to User Priority = 3
> and AC_BE (Best Effort).
> 

Reviewed-by: Guillaume Nault <gnault@redhat.com>


