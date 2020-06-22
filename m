Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C4E203DAD
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 19:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgFVRTF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 13:19:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49386 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbgFVRTF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 13:19:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05MHBa1f189447;
        Mon, 22 Jun 2020 17:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=C7ugc59ux1Tzk1qNRQTFHlVKwXEauG38RKV8mSsCQ5A=;
 b=RL7mFnPZA5Ye1rE+7GF9b2sgqSsaAmA1kxsDqwB0v2pG+ve7AH2nhmtEoviv+w3Rg7Oz
 uodvImc8D4FDmq26QFVXbOTrVdB8/rhhzO62WzzFJAeDDAy1GLlnKUHi1NFi9YNnfvkk
 1z8BWJQV+HeXh6thnM13d3soRzM01vGdunLLrmvZufl8WzZpa/OgDQoGwwvFkjta5AMq
 zqu2sVWtprqJgeHzPCPIorUWmaaIBa9DjEC6FdHa5xt70ExQMExuWz6jgAy6YTB1ei5m
 26U1htg/36OepPCLe34xP6fRkSWBsaC6x97QhptIie4PGfdJgF5T4TMHSQpHGyGZ12eK IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31sebb8pj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Jun 2020 17:18:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05MHE6j9018528;
        Mon, 22 Jun 2020 17:18:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31sv7qeygr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 17:18:56 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05MHIsKo008088;
        Mon, 22 Jun 2020 17:18:55 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jun 2020 17:18:53 +0000
Date:   Mon, 22 Jun 2020 20:18:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH net-next] ath11k: fix uninitialized return in
 ath11k_spectral_process_data()
Message-ID: <20200622171846.GE4151@kadam>
References: <20200619142922.GA267142@mwanda>
 <87a70vf923.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a70vf923.fsf@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006220120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 cotscore=-2147483648
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006220120
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jun 22, 2020 at 05:51:16PM +0300, Kalle Valo wrote:
> Dan Carpenter <dan.carpenter@oracle.com> writes:
> 
> > There is a success path where "ret" isn't initialized where we never
> > have a ATH11K_SPECTRAL_TAG_SCAN_SEARCH and then ret isn't initialized.
> >
> > Fixes: 9d11b7bff950 ("ath11k: add support for spectral scan")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/net/wireless/ath/ath11k/spectral.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
> > index 1c5d65bb411f..bfbf905f7507 100644
> > --- a/drivers/net/wireless/ath/ath11k/spectral.c
> > +++ b/drivers/net/wireless/ath/ath11k/spectral.c
> > @@ -677,7 +677,7 @@ static int ath11k_spectral_process_data(struct ath11k *ar,
> >  	u32 data_len, i;
> >  	u8 sign, tag;
> >  	int tlv_len, sample_sz;
> > -	int ret;
> > +	int ret = 0;
> >  	bool quit = false;
> 
> I try to avoid initialising ret variables so I would like find another
> way. What about doing this (completely untested!) in the end of the
> function:
> 
>         return 0;
> 
> err:
> 	kfree(fft_sample);
> unlock:
> 	spin_unlock_bh(&ar->spectral.lock);
> 	return ret;

I normally avoid it as well...  If I were to redo this patch, I would
probably do:

	ret = 0;
err:
	kfree(fft_sample);
unlock:
	spin_unlock_bh(&ar->spectral.lock);
	return ret;

Would that be better?

regards,
dan carpenter

