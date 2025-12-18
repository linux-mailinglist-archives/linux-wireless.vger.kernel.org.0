Return-Path: <linux-wireless+bounces-29902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC269CCCD00
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 17:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18AA330D1B06
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27433345CAE;
	Thu, 18 Dec 2025 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpB9Qjfx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CF43451B2;
	Thu, 18 Dec 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766075058; cv=none; b=JTRDtUOZObYUf3CzZVgGjKUDqFnWUzkVrxQA+uShYEzV/T9lxDLilPqPh2cH1UMyVUpTcXfFT/qQzV8vl1zupIAbj4LItY4wLH8GaAhZ7hFxZqjkriVazIu/Je7B7rThbzZFvyDcxAdq2ryx+rjnRBgFTkSqPUl1V6idmoH3KvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766075058; c=relaxed/simple;
	bh=X5gSMMJxTpeVSLwt9c3VGpJBP7cA+dKBFUTwA1R/8Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyjJ0+9OpXbh7IbIbaF0QNgwcjnyWdfsiWsHyXdfsJ22ofp45tVv0FUMZ4d0Q+7IxRomHNhMBgBx9JEd/OsmvSIC1Muj7Ps1TyFlQ9bjGg6HpAcqWTMqhpZ+7Xq5liy01k8paP94YnigN4iBTlDc3ZnLDUeHzkVYTYJAGJF+038=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpB9Qjfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742D1C4CEFB;
	Thu, 18 Dec 2025 16:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766075057;
	bh=X5gSMMJxTpeVSLwt9c3VGpJBP7cA+dKBFUTwA1R/8Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CpB9QjfxUGu7QHeL+Ttl3LbAbI0T6PGcte3cn+vIPi7DalYPSikxLc4VNjs+cpLMU
	 wAHm/NDnq3/9kUW0LDoX3+13AOelp2GqKXTYjoe50BFg7vDy3SO6luvKjh1dbx8+uX
	 esRJC+w0UZsPyGsE4IuZLrx1NXnDPaAPK7noFXUR3Sfa757BmSMq29w2iuXqHYK48p
	 MZaE4rqXx9iMTl7GFQzcqkHRmumgpFlPwZofAGeWpTNAx1AKVTt+Di4Upt2U7lFyTc
	 1X3wPqiVCqHD+JYpbvtv5JKyX0UGO6Mxcto4/3HoJJkrHjbEJkKYjYI8YoSW//pXSP
	 XLtDOMNb4Xjqg==
Date: Thu, 18 Dec 2025 21:54:07 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>, 
	Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxim Kochetkov <fido_max@inbox.ru>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	mhi@lists.linux.dev, linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	ath12k@lists.infradead.org, netdev@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Chris Lew <quic_clew@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] net: qrtr: Drop the MHI auto_queue feature for IPCR
 DL channels
Message-ID: <pm5amorzm2bvjrvswd4phwiic7wsmitxtzwdvtwqflepxkukjf@esikj32tds7o>
References: <20251217-qrtr-fix-v1-0-f6142a3ec9d8@oss.qualcomm.com>
 <20251217-qrtr-fix-v1-1-f6142a3ec9d8@oss.qualcomm.com>
 <CAFEp6-0iuJNDM9hdU3rWns=Vst6Ev1iyNim1ngRH3Z44CHwTAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEp6-0iuJNDM9hdU3rWns=Vst6Ev1iyNim1ngRH3Z44CHwTAg@mail.gmail.com>

On Wed, Dec 17, 2025 at 09:55:01PM +0100, Loic Poulain wrote:
> Hi Mani,
> 
> On Wed, Dec 17, 2025 at 6:17 PM Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
> >
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >
> > MHI stack offers the 'auto_queue' feature, which allows the MHI stack to
> > auto queue the buffers for the RX path (DL channel). Though this feature
> > simplifies the client driver design, it introduces race between the client
> > drivers and the MHI stack. For instance, with auto_queue, the 'dl_callback'
> > for the DL channel may get called before the client driver is fully probed.
> > This means, by the time the dl_callback gets called, the client driver's
> > structures might not be initialized, leading to NULL ptr dereference.
> >
> > Currently, the drivers have to workaround this issue by initializing the
> > internal structures before calling mhi_prepare_for_transfer_autoqueue().
> > But even so, there is a chance that the client driver's internal code path
> > may call the MHI queue APIs before mhi_prepare_for_transfer_autoqueue() is
> > called, leading to similar NULL ptr dereference. This issue has been
> > reported on the Qcom X1E80100 CRD machines affecting boot.
> >
> > So to properly fix all these races, drop the MHI 'auto_queue' feature
> > altogether and let the client driver (QRTR) manage the RX buffers manually.
> > In the QRTR driver, queue the RX buffers based on the ring length during
> > probe and recycle the buffers in 'dl_callback' once they are consumed. This
> > also warrants removing the setting of 'auto_queue' flag from controller
> > drivers.
> >
> > Currently, this 'auto_queue' feature is only enabled for IPCR DL channel.
> > So only the QRTR client driver requires the modification.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 227fee5fc99e ("bus: mhi: core: Add an API for auto queueing buffers for DL channel")
> > Fixes: 68a838b84eff ("net: qrtr: start MHI channel after endpoit creation")
> > Reported-by: Johan Hovold <johan@kernel.org>
> > Closes: https://lore.kernel.org/linux-arm-msm/ZyTtVdkCCES0lkl4@hovoldconsulting.com
> > Suggested-by: Chris Lew <quic_clew@quicinc.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/accel/qaic/mhi_controller.c   | 44 -----------------------
> >  drivers/bus/mhi/host/pci_generic.c    | 20 ++---------
> >  drivers/net/wireless/ath/ath11k/mhi.c |  4 ---
> >  drivers/net/wireless/ath/ath12k/mhi.c |  4 ---
> >  net/qrtr/mhi.c                        | 67 +++++++++++++++++++++++++++++------
> >  5 files changed, 58 insertions(+), 81 deletions(-)
> [...]
> > diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
> > index 69f53625a049..0b4d181ea747 100644
> > --- a/net/qrtr/mhi.c
> > +++ b/net/qrtr/mhi.c
> > @@ -24,13 +24,25 @@ static void qcom_mhi_qrtr_dl_callback(struct mhi_device *mhi_dev,
> >         struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
> >         int rc;
> >
> > -       if (!qdev || mhi_res->transaction_status)
> > +       if (!qdev || (mhi_res->transaction_status && mhi_res->transaction_status != -ENOTCONN))
> >                 return;
> >
> > +       /* Channel got reset. So just free the buffer */
> > +       if (mhi_res->transaction_status == -ENOTCONN) {
> > +               devm_kfree(&mhi_dev->dev, mhi_res->buf_addr);
> > +               return;
> > +       }
> > +
> >         rc = qrtr_endpoint_post(&qdev->ep, mhi_res->buf_addr,
> >                                 mhi_res->bytes_xferd);
> >         if (rc == -EINVAL)
> >                 dev_err(qdev->dev, "invalid ipcrouter packet\n");
> > +
> > +       /* Done with the buffer, now recycle it for future use */
> > +       rc = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, mhi_res->buf_addr,
> > +                          mhi_dev->mhi_cntrl->buffer_len, MHI_EOT);
> > +       if (rc)
> > +               dev_err(&mhi_dev->dev, "Failed to recycle the buffer: %d\n", rc);
> >  }
> >
> >  /* From QRTR to MHI */
> > @@ -72,6 +84,27 @@ static int qcom_mhi_qrtr_send(struct qrtr_endpoint *ep, struct sk_buff *skb)
> >         return rc;
> >  }
> >
> > +static int qcom_mhi_qrtr_queue_dl_buffers(struct mhi_device *mhi_dev)
> > +{
> > +       void *buf;
> > +       int ret;
> > +
> > +       while (!mhi_queue_is_full(mhi_dev, DMA_FROM_DEVICE)) {
> 
> This approach might be a bit racy, since a buffer could complete
> before the alloc+queue loop finishes. That could e.g lead to recycle
> error in a concurrent DL callback.

I don't think the race is possible as we just queue the buffers during probe and
resume. But I get your point, using mhi_get_free_desc_count() is more
straightforward.

- Mani

> It might be simpler to just queue
> the number of descriptors returned by mhi_get_free_desc_count().
> 
> > +               buf = devm_kmalloc(&mhi_dev->dev, mhi_dev->mhi_cntrl->buffer_len, GFP_KERNEL);
> > +               if (!buf)
> > +                       return -ENOMEM;
> > +
> > +               ret = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, buf, mhi_dev->mhi_cntrl->buffer_len,
> > +                                   MHI_EOT);
> > +               if (ret) {
> > +                       dev_err(&mhi_dev->dev, "Failed to queue buffer: %d\n", ret);
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
> >                                const struct mhi_device_id *id)
> >  {
> > @@ -87,20 +120,30 @@ static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
> >         qdev->ep.xmit = qcom_mhi_qrtr_send;
> >
> >         dev_set_drvdata(&mhi_dev->dev, qdev);
> > -       rc = qrtr_endpoint_register(&qdev->ep, QRTR_EP_NID_AUTO);
> > -       if (rc)
> > -               return rc;
> >
> >         /* start channels */
> > -       rc = mhi_prepare_for_transfer_autoqueue(mhi_dev);
> > -       if (rc) {
> > -               qrtr_endpoint_unregister(&qdev->ep);
> > +       rc = mhi_prepare_for_transfer(mhi_dev);
> > +       if (rc)
> >                 return rc;
> > -       }
> > +
> > +       rc = qrtr_endpoint_register(&qdev->ep, QRTR_EP_NID_AUTO);
> > +       if (rc)
> > +               goto err_unprepare;
> > +
> > +       rc = qcom_mhi_qrtr_queue_dl_buffers(mhi_dev);
> > +       if (rc)
> > +               goto err_unregister;
> >
> >         dev_dbg(qdev->dev, "Qualcomm MHI QRTR driver probed\n");
> >
> >         return 0;
> > +
> > +err_unregister:
> > +       qrtr_endpoint_unregister(&qdev->ep);
> > +err_unprepare:
> > +       mhi_unprepare_from_transfer(mhi_dev);
> > +
> > +       return rc;
> >  }
> 
> Regards,
> Loic

-- 
மணிவண்ணன் சதாசிவம்

