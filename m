Return-Path: <linux-wireless+bounces-1985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0F982F180
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 16:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6BE285222
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6DD1C290;
	Tue, 16 Jan 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Grg3RyAE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86A1C281
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bbc649c275so4455152b6e.0
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 07:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705418969; x=1706023769; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iJ8kDv4NT77wbV/RUW9AhIRHKupbHjNRdeQr3Ppsnl0=;
        b=Grg3RyAEhxNFh4XBEI2+PYopf+W6W602ZxENTAyo22cwj3gXyE8kxJDO2EY2kONti+
         V8+62OK+SSFy//JoyND16D1hP9tpam+R+8oai936XHC0ViIhn7f+E6HxcLJv1U1S/bMS
         FHZUcyP4+CR4j6LqD0Cj8qCt5MmRt33fAA1HbraEm7rcJDOlhMWCSxBpAZe/Ff8FGb4n
         YzKnY2/2TTqpdz5TcS0+6KBrBq5NwOsS3wGru4C3t50zdhNGoyswFWkLuEHL0GMrst47
         aXUeawXQYW3+vxE9WgyD5mHC/F0Ee7IMMDs+EYGsMfCHRbtrbW9yU/T/rzt/c0ANMgMj
         huGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705418969; x=1706023769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJ8kDv4NT77wbV/RUW9AhIRHKupbHjNRdeQr3Ppsnl0=;
        b=fHNP46oz8K1W2v9ZR7xNdD8G+BkLTFl72LK8udSpZlea73wu4WDulAeBjL/WuudHoE
         aLQRzNZGBxXO3PvEb44b60Xmn9t/0E8IxF1rhCWjJN1BzvUjLpPWK+gNKeHBZa3V/baX
         uaa0Q/Ed68PfSiNkPzjvtfeC7h4P/VOx1AoUxjsKZ3u7nIfdiwmaIzwxhQ95brqOGAvQ
         HDDXXPyQwcnjVylJwIVfz2Ji8gtmNui2ejWicnu8v0YRoyDy0RybPr3KPjGfXjdGD5Al
         NNtnxQVPQNE69jsvK0C6DtMTKnb9dBIqgCNWI+t0udngtyW2VqBcewaMpvHquJzoxdUN
         ok9A==
X-Gm-Message-State: AOJu0Yyjt/UA6g62AcyCvWA2/kxoP7UdDqIcirI7RDHSGNnB+Ga7Zfkp
	Ky8hh6GW/atLOhaxvHx4KwknLkBw8BWE/Q==
X-Google-Smtp-Source: AGHT+IGBWdHLHlu+WKmrXxmyfAaya9jZa+J4uJQ5YBat9EhQgRdlPfVABfpR7u3rUy/Ip3xt+opsKg==
X-Received: by 2002:a05:6808:2e91:b0:3bd:72dc:65a6 with SMTP id gt17-20020a0568082e9100b003bd72dc65a6mr3757509oib.58.1705418969400;
        Tue, 16 Jan 2024 07:29:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id q16-20020a05620a0c9000b007815844a295sm3800321qki.116.2024.01.16.07.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 07:29:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rPlNY-0045nl-7f;
	Tue, 16 Jan 2024 11:29:28 -0400
Date: Tue, 16 Jan 2024 11:29:28 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Kalle Valo <kvalo@kernel.org>, James Prestwood <prestwoj@gmail.com>,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: ath11k and vfio-pci support
Message-ID: <20240116152928.GF50608@ziepe.ca>
References: <df9fd970-5af3-468c-b1f1-18f91215cf44@gmail.com>
 <8734v4auc4.fsf@kernel.org>
 <e8878979-1f3f-4635-a716-9ac381c617d9@gmail.com>
 <285b84d0-229c-4c83-a7d6-4c3c23139597@quicinc.com>
 <4607fb37-8227-49a3-9e8c-10c9b117ec7b@gmail.com>
 <3d22a730-aee5-4f2a-9ddc-b4b5bd4d62fe@quicinc.com>
 <87il3w7zjh.fsf@kernel.org>
 <20240115104658.0b56bd35.alex.williamson@redhat.com>
 <543d9d2f-e132-4fdb-8454-68595cd20515@quicinc.com>
 <57d20bd812ccf8d1a5815ad41b5dcea3925d4fe1.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57d20bd812ccf8d1a5815ad41b5dcea3925d4fe1.camel@infradead.org>

On Tue, Jan 16, 2024 at 11:41:19AM +0100, David Woodhouse wrote:

> If we had had this posted interrupt support from the beginning, perhaps
> we could have have a much simpler model — we just let the guest write
> its intended (v)CPU#/vector *directly* to the MSI table in the device,
> and let the IOMMU fix it up by having a table pointing to the
> appropriate set of vCPUs. But that isn't how it happened. The model we
> have is that the VMM has to *emulate* the config space and handle the
> interrupts as described above.

I do have a strong desire to rework things to be more like this, just
not time yet :)

We have enough real problems related to the fake interrupt data in
the guest.

This ath11k thing sounds more like IMS really - it makes zero sense
that a device would be designed where the MSI vector has to be copied
to another location - most likely the other location is another
interrupt source that can be programmed independently, with its own
irqchip, etc? Linux supports this now. Thomas and Intel did it to
support SIOV IMS.

Are you sure you have implemented your Linux driver correctly? :)

Of course IMS doesn't work in VMs, but that is a big motivation to fix
the irq organizing. At least you'd know why the device is broken :)

Jason


