Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2363691C7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 14:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242324AbhDWMMY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 08:12:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45206 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230225AbhDWMMX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 08:12:23 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NC1l1q008767;
        Fri, 23 Apr 2021 12:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=pPvS3hUs7rnIQzLwuGR+6wn/bJD+Xtfq/yZfDJvmthg=;
 b=w1fyIdFCyrEv+gUfeP2KvEYJz88AMK/tN4jk556UIj6Snxn7cGHoh8ov7O6go+2wcT4p
 VqUVhW8jqP2whAONUQtU1XgohY6iHQkeAol3rD8j1iAibybljLSa1S/6gYhYTU4x8Gc1
 gnw6DRvM3DbTI720yfh7En1SQJpJ22NP8i0r1Js9i6jr2OngmvnaVHiRbbjbMIpeRSl3
 LoEZfiCG1HPTp5p3Ft/Bfj8hZ4nyBzy+6Cd/WCmccQxmiKmn8FFxSTZJEty39mh8kZqh
 +Q9J1w9qac1pOVY5riAdg32Dst2VvU6q4v/MAqq90114xsPjsLwpXK752LcnV7+Bmqk2 vQ== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 382unxgq8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 12:11:34 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13NCBXmT024132;
        Fri, 23 Apr 2021 12:11:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 383cbf4su9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 12:11:33 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13NCBUgO023121;
        Fri, 23 Apr 2021 12:11:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 383cbf4sk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 12:11:30 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13NCBIa5024528;
        Fri, 23 Apr 2021 12:11:18 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 23 Apr 2021 05:11:18 -0700
Date:   Fri, 23 Apr 2021 15:11:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Hans deGoede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] brcmfmac: fix a loop exit condition
Message-ID: <20210423121110.GO1981@kadam>
References: <YIKzmoMiTdToaIyP@mwanda>
 <427e33af49758c61bc23cf1eedb6dd6964c40296.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <427e33af49758c61bc23cf1eedb6dd6964c40296.camel@sipsolutions.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: -rKlaEIEEnSY_QthzAfSPIdlyxifXZjt
X-Proofpoint-ORIG-GUID: -rKlaEIEEnSY_QthzAfSPIdlyxifXZjt
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 23, 2021 at 01:59:36PM +0200, Johannes Berg wrote:
> On Fri, 2021-04-23 at 14:46 +0300, Dan Carpenter wrote:
> > This code is supposed to loop over the whole board_type[] string.  The
> > current code kind of works just because ascii values start 97 and the
> > string is likely shorter than that so it will break when we hit the NUL
> > terminator.  But really the condition should be "i < len" instead of
> > "i < board_type[i]".
> > 
> > Fixes: 29e354ebeeec ("brcmfmac: Transform compatible string for FW loading")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> > index a7554265f95f..9b75e396fc50 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> > @@ -34,7 +34,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
> >  		len = strlen(tmp) + 1;
> >  		board_type = devm_kzalloc(dev, len, GFP_KERNEL);
> >  		strscpy(board_type, tmp, len);
> > -		for (i = 0; i < board_type[i]; i++) {
> > +		for (i = 0; i < len; i++) {
> >  			if (board_type[i] == '/')
> >  				board_type[i] = '-';
> >  		}
> 
> It should probably just use strreplace() though :)

Good point.  I'll send a v2.

regards,
dan carpenter

