Return-Path: <linux-wireless+bounces-29850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC21CC9863
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 21:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FDAE300D4B3
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 20:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7FB2F12DB;
	Wed, 17 Dec 2025 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="frgUq2na";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="daVOfudq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B1223F429
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766004916; cv=none; b=RPO7hyKpWJzAbca6qvHXViMEOfXEoAtirgxfzLo2SHylQjrJzntQyxAXKddVfpUqlPLNwYodIteLP3qwQ7GA4Cpo6yWL+lLURt4eoV4XN0e62wbgm08weDXDDKB8koF0a1HQdFXXhE0xjXunF2HN0wBf6ACx/BKtpuKUPLga0S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766004916; c=relaxed/simple;
	bh=ZcCopzOY7izL11ae5HCSHWlmhMGLhCXPDvIU4yKWWi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptz1/+rWuwwmzTyHCCttCLgCOX8jEFD+48CXKAuM0fX1S44RIR1lz23elnWzwU9P9tv21m4acMObWrmeW5YPWljZ1B+0sJBWhlYcJ2Xd4Tby0/ybrzW399ZD/aqdoTtdznfvFvuIyQwabjyskWweiGCS3xoxNa/fGXOBhUkhFl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=frgUq2na; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=daVOfudq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHJBKCF019642
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 20:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HgMaZiIuQy5vybIqaOL5aswqYfbddufKQttDrC14/fE=; b=frgUq2naW/f3Z10b
	qhlkzoQG/bBIkMHs9pjkrJlAllgM/1Sc8QGkpXI0tnnN+20I24C9vY0ZESuahSd8
	+c2gk+U75SLx+IRGoOEweVFcWESkD3fiLfgKC1hm9Y8egrFQ/Mi0Xdip193OAkCg
	7v1UmOWgOcmGdD4PW1Lm4wGYJH6gJZYTZwpb7jlBzBF114KKcH8doXizoAbDjYYV
	tphoXAuxeMwhhpY3ZVi5ZYvA7KY36al6VVmCEDkTMCC/xFQCvLyKlRhSBolJlziI
	GXjGfORKUacLpAJRIPFOp6VL1+8oYjTPpTAzoExAjN2x/4H0DnksSMj+EMIk2RNJ
	2fgYPQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40v78hm7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 20:55:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f1b39d7ed2so130412971cf.2
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 12:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766004913; x=1766609713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgMaZiIuQy5vybIqaOL5aswqYfbddufKQttDrC14/fE=;
        b=daVOfudqydBn1MB/VCPyJtcRV7upY0gJQSgVESv3yDcsyBk6nxm9azsx9ZL6br4ESK
         /s4j1a8y8h/PP80QYQ7TmIKjsHb1WgYRF8WUCbde/+YOIO45hVOws6PB4o0EhO88ov8i
         ipeivsq8XvRs7SGwrmfuPtKeL+oGYyP3Lg9z0acf+beiHPfUKSjQsTq2u2sV3yMCs7V1
         mStQf8J3HhhmlnrKmKf4J35qvsyjhBvD29BaJCZiC2TAqa7QeICILPe3CFGfQsk1xfyM
         rcJlQerOTpHGTaCgqW/T2FvwWkqqn1RdKQl1MNrPtXZRAWAA2sAnL6cPQePxiVrtjwG8
         SOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766004913; x=1766609713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HgMaZiIuQy5vybIqaOL5aswqYfbddufKQttDrC14/fE=;
        b=sst6vRqrarAA2cuMoBmZjZOum2IcDxbIR94muJ06xCy3O/HLS3ft8hK9lvd/rw45RR
         OEqr4d1ZQFZzwEPBd4shNCqEF2pH+fLKPTUorsjwTsDFcpln20FE8ESYNXUschDbKUEF
         9oqVa+klCyri0lynJvCpwoo3g2AvJsTXyp8CfehbSRmWesjAoTNgk+GJQmgpaLWICCCo
         X3XNGYTtkXVLE8umujEanqmUaR4OlBKo+205sFLZHE480f/MvgOChNXfAjZh7TFnAv3s
         oDWXyQg+pIRImwnwu3EXTW7rHw1zuLrwMqsXp9wMAUVUWWN7fcixE70X6nyej0TK7TfH
         ++cA==
X-Forwarded-Encrypted: i=1; AJvYcCXTH1LDhKCptfYsnyQ2QjUYLV09k1iClmgQHGK1TdhTwY3r85U2M7vLs29s/Y2WhH94l2eGFFBYgEKokSNJ3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9FCRO7XbB0U+lK/ZJztkDNMp2dO4c8RBl/+Wj/ulezIheIzc7
	PFyWprwMeCRgysktv57Xfe94x+wkBtnP2d8fDFbb5jaaOkHJp/MdQNPI67gPVYFnCtxfU756ROp
	BX2ngfTwSpAEOHE77p12lWlzCNdiaL42v9dyHi7qSuI5mqZqeHiU6LgK9taBTFu7rzNDWAOQkYs
	wrsUpyA3+B0W5vhk/mRGMvligPLsZyeZvkPGuQ5EX0UdcM
X-Gm-Gg: AY/fxX6NmLWFoTSS/1d+p1b2nUgyd5AolKUk80mgo9mTmc5BD5Kl0HFp9Yf3cRAvQMr
	sWFYUQV8GrKyNItaK2o8H/N5fcJ5wDvPnRLfYpBdWYVcANKSRpWnXj7DCw9npQk4QYesRSuZhVE
	DZu95LIWqVYRdN5KcqV72AE6Cdkc0iY/8I6sdUX34unnloX6za3n1dFgE3rtOrFH4zyvZEjbHIM
	V6lqHdoOLd5fYiRKGFzt2MqTNg=
X-Received: by 2002:a05:622a:1f8d:b0:4e8:aff9:a7a8 with SMTP id d75a77b69052e-4f1d059e6demr255486181cf.52.1766004913116;
        Wed, 17 Dec 2025 12:55:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIxV8yAj25Ai89Xzbv01C4M56wH08D8F+HimFkmmUMgUnz2y/j/qSKVn3Br5Bb5T4cygsAlkkPPFEOhhJoBLc=
X-Received: by 2002:a05:622a:1f8d:b0:4e8:aff9:a7a8 with SMTP id
 d75a77b69052e-4f1d059e6demr255485861cf.52.1766004912714; Wed, 17 Dec 2025
 12:55:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217-qrtr-fix-v1-0-f6142a3ec9d8@oss.qualcomm.com> <20251217-qrtr-fix-v1-1-f6142a3ec9d8@oss.qualcomm.com>
In-Reply-To: <20251217-qrtr-fix-v1-1-f6142a3ec9d8@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 21:55:01 +0100
X-Gm-Features: AQt7F2oMGXyRcd9Myafrtktq7XvNVC31AVGxMw8-BPcHboXB0o1yL4pAKjFRRZ0
Message-ID: <CAFEp6-0iuJNDM9hdU3rWns=Vst6Ev1iyNim1ngRH3Z44CHwTAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: qrtr: Drop the MHI auto_queue feature for IPCR
 DL channels
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxim Kochetkov <fido_max@inbox.ru>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        netdev@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>, Chris Lew <quic_clew@quicinc.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 57QXDz1Ovqwnq21qD77HOSqKjBimjBnC
X-Proofpoint-GUID: 57QXDz1Ovqwnq21qD77HOSqKjBimjBnC
X-Authority-Analysis: v=2.4 cv=f8JFxeyM c=1 sm=1 tr=0 ts=694318b1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=b7YbY6zhk6ih5Eb82B4A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=xwnAI6pc5liRhupp6brZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE2NiBTYWx0ZWRfX5HfGf/pQYbZl
 UU4Z0qSZs/vjz7k+nvJT8Fn4+31Otht15078Pq1lVFtlC9hIeGwDEWTrva7pMYtxmIq3kfVLbfW
 oBGsb5NZsVNu9C7eMjmivuDUI5we6Jy6oy8ACEapKNnpBR2o3JpYsAonKB0nE4WYeSxPXnPPy1P
 eUv53hBfDe+3Foc8v6JfAD+xRzvIj/Wlv7QaZfeVdo35KwChY9MFCmQa+xfm6BpoKzrhIO7z7Zz
 SEog++x+SN3OWNS+vn+gpZTfZBwo7d3svA1qORfsQKzAw+TSqVPI4N//6uxxWrAT8PyPm+fHgcg
 sSsnMT6gyxXP6/QIH/xNg9EmSSIWmkZp9EYblBgRfH25EI/NBY1aKnC/Tc5+WigXA39Pjh2ijDp
 iKHm3R7gYjiyLd7Xd/NNJSGanWKD6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170166

Hi Mani,

On Wed, Dec 17, 2025 at 6:17=E2=80=AFPM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> MHI stack offers the 'auto_queue' feature, which allows the MHI stack to
> auto queue the buffers for the RX path (DL channel). Though this feature
> simplifies the client driver design, it introduces race between the clien=
t
> drivers and the MHI stack. For instance, with auto_queue, the 'dl_callbac=
k'
> for the DL channel may get called before the client driver is fully probe=
d.
> This means, by the time the dl_callback gets called, the client driver's
> structures might not be initialized, leading to NULL ptr dereference.
>
> Currently, the drivers have to workaround this issue by initializing the
> internal structures before calling mhi_prepare_for_transfer_autoqueue().
> But even so, there is a chance that the client driver's internal code pat=
h
> may call the MHI queue APIs before mhi_prepare_for_transfer_autoqueue() i=
s
> called, leading to similar NULL ptr dereference. This issue has been
> reported on the Qcom X1E80100 CRD machines affecting boot.
>
> So to properly fix all these races, drop the MHI 'auto_queue' feature
> altogether and let the client driver (QRTR) manage the RX buffers manuall=
y.
> In the QRTR driver, queue the RX buffers based on the ring length during
> probe and recycle the buffers in 'dl_callback' once they are consumed. Th=
is
> also warrants removing the setting of 'auto_queue' flag from controller
> drivers.
>
> Currently, this 'auto_queue' feature is only enabled for IPCR DL channel.
> So only the QRTR client driver requires the modification.
>
> Cc: stable@vger.kernel.org
> Fixes: 227fee5fc99e ("bus: mhi: core: Add an API for auto queueing buffer=
s for DL channel")
> Fixes: 68a838b84eff ("net: qrtr: start MHI channel after endpoit creation=
")
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/linux-arm-msm/ZyTtVdkCCES0lkl4@hovoldcons=
ulting.com
> Suggested-by: Chris Lew <quic_clew@quicinc.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  drivers/accel/qaic/mhi_controller.c   | 44 -----------------------
>  drivers/bus/mhi/host/pci_generic.c    | 20 ++---------
>  drivers/net/wireless/ath/ath11k/mhi.c |  4 ---
>  drivers/net/wireless/ath/ath12k/mhi.c |  4 ---
>  net/qrtr/mhi.c                        | 67 +++++++++++++++++++++++++++++=
------
>  5 files changed, 58 insertions(+), 81 deletions(-)
[...]
> diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
> index 69f53625a049..0b4d181ea747 100644
> --- a/net/qrtr/mhi.c
> +++ b/net/qrtr/mhi.c
> @@ -24,13 +24,25 @@ static void qcom_mhi_qrtr_dl_callback(struct mhi_devi=
ce *mhi_dev,
>         struct qrtr_mhi_dev *qdev =3D dev_get_drvdata(&mhi_dev->dev);
>         int rc;
>
> -       if (!qdev || mhi_res->transaction_status)
> +       if (!qdev || (mhi_res->transaction_status && mhi_res->transaction=
_status !=3D -ENOTCONN))
>                 return;
>
> +       /* Channel got reset. So just free the buffer */
> +       if (mhi_res->transaction_status =3D=3D -ENOTCONN) {
> +               devm_kfree(&mhi_dev->dev, mhi_res->buf_addr);
> +               return;
> +       }
> +
>         rc =3D qrtr_endpoint_post(&qdev->ep, mhi_res->buf_addr,
>                                 mhi_res->bytes_xferd);
>         if (rc =3D=3D -EINVAL)
>                 dev_err(qdev->dev, "invalid ipcrouter packet\n");
> +
> +       /* Done with the buffer, now recycle it for future use */
> +       rc =3D mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, mhi_res->buf_addr,
> +                          mhi_dev->mhi_cntrl->buffer_len, MHI_EOT);
> +       if (rc)
> +               dev_err(&mhi_dev->dev, "Failed to recycle the buffer: %d\=
n", rc);
>  }
>
>  /* From QRTR to MHI */
> @@ -72,6 +84,27 @@ static int qcom_mhi_qrtr_send(struct qrtr_endpoint *ep=
, struct sk_buff *skb)
>         return rc;
>  }
>
> +static int qcom_mhi_qrtr_queue_dl_buffers(struct mhi_device *mhi_dev)
> +{
> +       void *buf;
> +       int ret;
> +
> +       while (!mhi_queue_is_full(mhi_dev, DMA_FROM_DEVICE)) {

This approach might be a bit racy, since a buffer could complete
before the alloc+queue loop finishes. That could e.g lead to recycle
error in a concurrent DL callback. It might be simpler to just queue
the number of descriptors returned by mhi_get_free_desc_count().

> +               buf =3D devm_kmalloc(&mhi_dev->dev, mhi_dev->mhi_cntrl->b=
uffer_len, GFP_KERNEL);
> +               if (!buf)
> +                       return -ENOMEM;
> +
> +               ret =3D mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, buf, mhi_=
dev->mhi_cntrl->buffer_len,
> +                                   MHI_EOT);
> +               if (ret) {
> +                       dev_err(&mhi_dev->dev, "Failed to queue buffer: %=
d\n", ret);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int qcom_mhi_qrtr_probe(struct mhi_device *mhi_dev,
>                                const struct mhi_device_id *id)
>  {
> @@ -87,20 +120,30 @@ static int qcom_mhi_qrtr_probe(struct mhi_device *mh=
i_dev,
>         qdev->ep.xmit =3D qcom_mhi_qrtr_send;
>
>         dev_set_drvdata(&mhi_dev->dev, qdev);
> -       rc =3D qrtr_endpoint_register(&qdev->ep, QRTR_EP_NID_AUTO);
> -       if (rc)
> -               return rc;
>
>         /* start channels */
> -       rc =3D mhi_prepare_for_transfer_autoqueue(mhi_dev);
> -       if (rc) {
> -               qrtr_endpoint_unregister(&qdev->ep);
> +       rc =3D mhi_prepare_for_transfer(mhi_dev);
> +       if (rc)
>                 return rc;
> -       }
> +
> +       rc =3D qrtr_endpoint_register(&qdev->ep, QRTR_EP_NID_AUTO);
> +       if (rc)
> +               goto err_unprepare;
> +
> +       rc =3D qcom_mhi_qrtr_queue_dl_buffers(mhi_dev);
> +       if (rc)
> +               goto err_unregister;
>
>         dev_dbg(qdev->dev, "Qualcomm MHI QRTR driver probed\n");
>
>         return 0;
> +
> +err_unregister:
> +       qrtr_endpoint_unregister(&qdev->ep);
> +err_unprepare:
> +       mhi_unprepare_from_transfer(mhi_dev);
> +
> +       return rc;
>  }

Regards,
Loic

