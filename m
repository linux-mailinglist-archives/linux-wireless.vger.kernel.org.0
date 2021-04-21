Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AD4366CF1
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 15:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbhDUNgL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 09:36:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20638 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234038AbhDUNgK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 09:36:10 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LDS3WW029034;
        Wed, 21 Apr 2021 13:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=UeMdVRe4bHpnIpI87GLbu9BgqITFB617fpRxifWCetg=;
 b=ycBflKyXa4oy0AT94y20BB0Cognrwe3qtbhcnt2La/NLDtcv1eOP40S4z9UYqy75Xgvc
 z7L85FNiWNhN931jqwvCYp940IE59cwsknmm158HaFs56cVGLlbT/5qDSScqpN9B4Eq3
 17arfdz7f0k+rnM3Kz27E06iHtUIrZEJSkM2Skh0pCbB9R8sG5jUPDqoigcMG+5nwKl8
 hnnf1FLxfn+crOvF6MH+hQurZp9EjRb38AUBLqvgUFrAHhd9GQnRVj9mzFEwRJ/alE0X
 sUK/ttaTp9CLTfjtx/yZxEpmUBVWGbCCR3pPj+KtMdaD1rXS7A0uy4V23NIewVHmAEw5 2A== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3818whgqym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:35:24 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13LDZNmr179327;
        Wed, 21 Apr 2021 13:35:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 38098rrbd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:35:23 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13LDZ6gh178091;
        Wed, 21 Apr 2021 13:35:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 38098rrbcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Apr 2021 13:35:22 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13LDZK2x031000;
        Wed, 21 Apr 2021 13:35:21 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Apr 2021 06:35:19 -0700
Date:   Wed, 21 Apr 2021 16:35:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/3] mt76: mt7915: fix a precision vs width bug in printk
Message-ID: <20210421133511.GH1959@kadam>
References: <YIAlYknkd0SoD6SY@mwanda>
 <87ecf5b648ea6d42994abbef8d9cde7e15a0a837.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecf5b648ea6d42994abbef8d9cde7e15a0a837.camel@sipsolutions.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: JA_PlnUt8JIfTKlRo1hL60umWHaOjUJu
X-Proofpoint-GUID: JA_PlnUt8JIfTKlRo1hL60umWHaOjUJu
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Apr 21, 2021 at 03:29:31PM +0200, Johannes Berg wrote:
> On Wed, 2021-04-21 at 16:15 +0300, Dan Carpenter wrote:
> > Precision %.*s was intended instead of width %.*s.
> > 
> 
> typo there, the second instance should say "width %*s" :-)

The hunter has become the hunted.  *dramatic music.  dah dah dah.*

:P

Thanks.

regards,
dan carpenter

