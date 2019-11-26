Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE7E109ACB
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 10:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfKZJM3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 04:12:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37380 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfKZJM2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 04:12:28 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQ99ZwJ151182;
        Tue, 26 Nov 2019 09:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=vBFYxD5eX5SLS6j0PeqYaAQGAAnUoAlDa0EHrwQ2cYQ=;
 b=qMQWtk+bDq0kTRJwbilMILum8GO4rnDA7RGWWqUU9uNr6nC46XzppUSSvLtpTWlcoEOk
 HTX3adywYy9leOJ6q7ZrO8yMix2r3Tmihub+Uqs6SExe1xs+3/cWKM8P7x92DOEyqkPH
 PTkHKes/ZHDhUewtluDDBHKbTvpTePtV03oqjUzxFDYB1g1GMbV3vYAKvoE+QCeIGyOp
 6wfStDdG1G2P0N3raXe0bi06u8kAj1/e/4VicfvfU92XIhFZg5VYpwGsToj1JBCuSm/j
 O9SiVa57MokasSGmiaNPqGjATtMZbIKahJq4OEO6J1jU2ojZmnBBKbYbJ+IcVCjniwZC Jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wevqq5d3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 09:12:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQ98vPV014671;
        Tue, 26 Nov 2019 09:12:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wgwus9d81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 09:12:02 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAQ9C0cx025823;
        Tue, 26 Nov 2019 09:12:00 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Nov 2019 01:11:59 -0800
Date:   Tue, 26 Nov 2019 12:11:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>, Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mt76: Off by one in mt76_calc_rx_airtime()
Message-ID: <20191126091150.GA1759@kadam>
References: <20191121213935.2cbgh3qmd4hv4v5a@kili.mountain>
 <87v9r7ysg0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v9r7ysg0.fsf@toke.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911260083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911260083
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 26, 2019 at 09:04:15AM +0100, Toke Høiland-Jørgensen wrote:
> Dan Carpenter <dan.carpenter@oracle.com> writes:
> 
> > The sband->bitrates[] array has "sband->n_bitrates" elements so this
> > check needs to be >= instead of > or we could read beyond the end of the
> > array.
> >
> > These values come from when we call mt76_register_device():
> >
> > 	ret = mt76_register_device(&dev->mt76, true, mt7603_rates,
> > 				   ARRAY_SIZE(mt7603_rates));
> >
> > Here sband->bitrates[] is mt7603_rates[] and ->n_bitrates is the
> > ARRAY_SIZE()
> >
> > Fixes: 5ce09c1a7907 ("mt76: track rx airtime for airtime fairness and survey")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/net/wireless/mediatek/mt76/airtime.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/airtime.c b/drivers/net/wireless/mediatek/mt76/airtime.c
> > index 55116f395f9a..a4a785467748 100644
> > --- a/drivers/net/wireless/mediatek/mt76/airtime.c
> > +++ b/drivers/net/wireless/mediatek/mt76/airtime.c
> > @@ -242,7 +242,7 @@ u32 mt76_calc_rx_airtime(struct mt76_dev *dev, struct mt76_rx_status *status,
> >  			return 0;
> >  
> >  		sband = dev->hw->wiphy->bands[status->band];
> > -		if (!sband || status->rate_idx > sband->n_bitrates)
> > +		if (!sband || status->rate_idx >= sband->n_bitrates)
> >  			return 0;
> >  
> >  		rate = &sband->bitrates[status->rate_idx];
> 
> This code has recently been ported to mac80211 (net/mac80211/airtime.c).
> It seems that the bug is also present there; care to send a patch for
> that as well? :)

Oh.  Thanks for pointing that out.  I actually saw the static checker
warning for that and ignored it thinking that it was the same code.  :P

I will send a fix for it.

regards,
dan carpenter

