Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C43A314A07
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 09:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBIIL6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 03:11:58 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39990 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhBIILj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 03:11:39 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11989w6H049624;
        Tue, 9 Feb 2021 08:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=6WBn+2Hi2T1V/VaRwjSEeDcMUQ5xJY2XA4AOwl22ZW4=;
 b=u/y9VV4oA9IXWDqJarKH/bJ3umy9IFNSP6YEPfzxqv5ePKqOMvvAxPUY1Dr0JGfTAK6V
 KVNcAxmIZaNrVR4aTDqjSr88/xj+0wy0uz8UdIvoDrRn5nl9rGfUnRrp8oDtUwbAArM+
 CVzEhJS8yHktKUzJv/Mpn0p7lPb3T+5S+I+x0MQ39zTxNTbFHsWZrkH/+k2IgZMIEpOb
 xPYtZqD95vR7CC1Z3CSv659+LUyYXUA8650lkJHnxoEkL6LdV9iZTVUjLXy8JLlY7GxO
 5ffe3aG1ZkcYCzgY2ikxutIXP9sdbYu7992Ok4X5qi+lnJeGK5lmERgN4pA6AYvQdMIN ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 36hkrmxhdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 08:10:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11981PEX018041;
        Tue, 9 Feb 2021 08:10:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 36j510w0pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 08:10:45 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1198AhUP024443;
        Tue, 9 Feb 2021 08:10:43 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Feb 2021 00:10:42 -0800
Date:   Tue, 9 Feb 2021 11:10:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Peter Oh <peter.oh@eero.com>, kernel-janitors@vger.kernel.org,
        Carl Huang <cjhuang@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v2] ath11k: fix a locking bug in ath11k_mac_op_start()
Message-ID: <20210209081032.GP20820@kadam>
References: <YBk4GoeE+yc0wlJH@mwanda>
 <87ft25vg1t.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft25vg1t.fsf@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090037
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090038
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Feb 09, 2021 at 09:47:10AM +0200, Kalle Valo wrote:
> Dan Carpenter <dan.carpenter@oracle.com> writes:
> 
> > This error path leads to a Smatch warning:
> >
> > 	drivers/net/wireless/ath/ath11k/mac.c:4269 ath11k_mac_op_start()
> > 	error: double unlocked '&ar->conf_mutex' (orig line 4251)
> >
> > We're not holding the lock when we do the "goto err;" so it leads to a
> > double unlock.  The fix is to hold the lock for a little longer.
> >
> > Fixes: c83c500b55b6 ("ath11k: enable idle power save mode")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > v2: reviewers were concern that v1 was racy
> >
> >  drivers/net/wireless/ath/ath11k/mac.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> > index c1608f64ea95..464d3425488b 100644
> > --- a/drivers/net/wireless/ath/ath11k/mac.c
> > +++ b/drivers/net/wireless/ath/ath11k/mac.c
> > @@ -4248,8 +4248,6 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
> >  	/* Configure the hash seed for hash based reo dest ring selection */
> >  	ath11k_wmi_pdev_lro_cfg(ar, ar->pdev->pdev_id);
> >  
> > -	mutex_unlock(&ar->conf_mutex);
> > -
> >  	rcu_assign_pointer(ab->pdevs_active[ar->pdev_idx],
> >  			   &ab->pdevs[ar->pdev_idx]);
> >  
> > @@ -4262,6 +4260,9 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
> >  			goto err;
> >  		}
> >  	}
> > +
> > +	mutex_unlock(&ar->conf_mutex);
> > +
> >  	return 0;
> >  
> >  err:
> > -- 
> > 2.30.0
> 
> But now rcu_assign_pointer() is called while conf_mutex is held,
> previously it was not. I didn't check if this creates problems, but just
> to be on the safe side I modified your patch to keep the original
> functionality. Please check my changes in the pending branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=8eff3667c211072a2107271139b81cbf8c7fd10a 
> 

I don't think the assignment is a problem, but I'm also fine with the
way you modified the patch.  Thanks!

regards,
dan carpenter

