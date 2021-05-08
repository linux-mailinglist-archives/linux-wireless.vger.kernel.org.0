Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494BB377150
	for <lists+linux-wireless@lfdr.de>; Sat,  8 May 2021 13:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhEHLEH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 May 2021 07:04:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48934 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhEHLEH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 May 2021 07:04:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 148B04bv063085;
        Sat, 8 May 2021 11:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=r0/XXh/jtriWu0VTLHZImPY97JqBO6EFOErMsyS74R4=;
 b=AEJc8qscz/htwff9kWW6Jkp31joSrGYdy6Ou0frzYqoCrhEjDYrccRAxek4V4bAK0ZpF
 asrfGof4h/19YhxNXwi5idpy301nEksGRHrzl39dzB52ZUfkoOGcDmPXVdOC8VgTK0ig
 ycK9DCEILHFsbz143RP2o4ZtpDJLhkIkAda0nyC4lGTNTsHp8+JRX3vW0HtAjfGPWjBw
 5cgR5CsQysy2H9HwM39H/oGoaiLRgd6Wmwp5xya4oDAU/UvJyZkj7C/d6NSe9cJu0568
 IeNCHZzEBxuaIRBVD7RHUWh1sYS3Oqr3vlYyucsmRpVenMXmNsUrnepU1M8x5LC/M+Lx iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 38dj2r0c84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 May 2021 11:02:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 148B1PmQ007865;
        Sat, 8 May 2021 11:02:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38dfrs41ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 May 2021 11:02:48 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 148B2l3W010552;
        Sat, 8 May 2021 11:02:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 38dfrs41ty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 May 2021 11:02:47 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 148B2jei026189;
        Sat, 8 May 2021 11:02:45 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 May 2021 11:02:45 +0000
Date:   Sat, 8 May 2021 14:02:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Arend van Spriel <aspriel@gmail.com>,
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
Message-ID: <20210508110235.GM1922@kadam>
References: <YIKzmoMiTdToaIyP@mwanda>
 <427e33af49758c61bc23cf1eedb6dd6964c40296.camel@sipsolutions.net>
 <20210423121110.GO1981@kadam>
 <bda7ae6b-00f9-ae0e-66d3-413049bc543d@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bda7ae6b-00f9-ae0e-66d3-413049bc543d@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: K383e4lnf4Wq4ZGo9c0t87Ao7TSeJRZm
X-Proofpoint-GUID: K383e4lnf4Wq4ZGo9c0t87Ao7TSeJRZm
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9977 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105080080
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 23, 2021 at 02:20:35PM +0200, Christophe JAILLET wrote:
> Le 23/04/2021 à 14:11, Dan Carpenter a écrit :
> > On Fri, Apr 23, 2021 at 01:59:36PM +0200, Johannes Berg wrote:
> > > On Fri, 2021-04-23 at 14:46 +0300, Dan Carpenter wrote:
> > > > This code is supposed to loop over the whole board_type[] string.  The
> > > > current code kind of works just because ascii values start 97 and the
> > > > string is likely shorter than that so it will break when we hit the NUL
> > > > terminator.  But really the condition should be "i < len" instead of
> > > > "i < board_type[i]".
> > > > 
> > > > Fixes: 29e354ebeeec ("brcmfmac: Transform compatible string for FW loading")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > ---
> > > >   drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> > > > index a7554265f95f..9b75e396fc50 100644
> > > > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> > > > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> > > > @@ -34,7 +34,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
> > > >   		len = strlen(tmp) + 1;
> > > >   		board_type = devm_kzalloc(dev, len, GFP_KERNEL);
> > > >   		strscpy(board_type, tmp, len);
> > > > -		for (i = 0; i < board_type[i]; i++) {
> > > > +		for (i = 0; i < len; i++) {
> > > >   			if (board_type[i] == '/')
> > > >   				board_type[i] = '-';
> > > >   		}
> > > 
> > > It should probably just use strreplace() though :)
> > 
> > Good point.  I'll send a v2.
> > 
> 
> and the 2 lines above look like a devm_kstrdup.
> 
> The (unlikely) malloc failure test is also missing.

It turns out that Smatch checks for allocation failure were really
ancient and really crap...  I need to add all devm_ functions.
Probably should re-write all that code.

Also originally GFP_NOFAIL was 0x800 and now it is 0x8000.  Smatch
was out of sync.  So the functions that were supposed to be checked
were all disabled...  Need to figure out a better way to do that as
well.

regards,
dan carpenter

