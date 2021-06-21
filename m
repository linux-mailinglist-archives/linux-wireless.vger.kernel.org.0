Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C9E3AE964
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 14:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhFUMuH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 08:50:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42946 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229640AbhFUMuG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 08:50:06 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LClEoi001661;
        Mon, 21 Jun 2021 12:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=7zFZSWF0OEYfmYJ+Gtbxaj390ZBYoHycTFS8z9bli5I=;
 b=L3T2KOk0WtRa0emunlEFySJ3IGypUC+YmE6fbg5sYKwA6rW7fURNU3J+GDmeQNiJf1wR
 3Ieo7040eYszKzmCV/NxtPHeX+ITckuzum7qZ9Gmr6dHpjrNIvfn61lNFwNtWBFss0Wu
 XryLEvRwWBWtr7t8BXmDoCLOM4f7cKWApGhBVKaTa9dTuRWjVc2f7hYulDYJV/6JENQ0
 4Xg8dTh1WRY8WLH1j4H4Sf7qCV54AYX5sOcBG7fWcr58Xdkn7Mk4tF2BnEwq75eRzQUn
 9I+rB0/XP934ZR4o0xKtTH+I6nkZ2RIsJHoaT3q1adCJTx1OWwQHBjzrKPOtQp3r0U/R jA== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39as86r6yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 12:47:41 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15LCleCl166380;
        Mon, 21 Jun 2021 12:47:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3996mbvv8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 12:47:40 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15LCleFv166359;
        Mon, 21 Jun 2021 12:47:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3996mbvv7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 12:47:40 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15LClaiT031178;
        Mon, 21 Jun 2021 12:47:37 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Jun 2021 05:47:36 -0700
Date:   Mon, 21 Jun 2021 15:47:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] brcmfmac: fix "board_type" in brcmf_of_probe()
Message-ID: <20210621124727.GI1861@kadam>
References: <YNCHELb14+eNV94n@mwanda>
 <6e0b8291-8c61-c172-30ce-031910009d04@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e0b8291-8c61-c172-30ce-031910009d04@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: ND1RRGM1KF-z691wgIRl_aQEmXPAXuu9
X-Proofpoint-GUID: ND1RRGM1KF-z691wgIRl_aQEmXPAXuu9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jun 21, 2021 at 02:41:03PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 6/21/21 2:33 PM, Dan Carpenter wrote:
> > There are two bugs here:
> > 1) devm_kzalloc() needs to be checked for allocation errors.
> > 2) The loop was intended to be:
> > 
> >  Bad:	for (i = 0; i < board_type[i]; i++) {
> > Good:	for (i = 0; i < len; i++) {
> > 
> > Neither of these bugs are likely to cause an issue in practice but
> > they're worth fixing.  Also the code could be made simpler by using the
> > devm_kstrdup() and strreplace() functions.
> > 
> > Fixes: 29e354ebeeec ("brcmfmac: Transform compatible string for FW loading")
> > Suggested-by: Johannes Berg <johannes@sipsolutions.net>
> > Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > v2: Basically a completely different patch.  :)
> > 
> >  .../net/wireless/broadcom/brcm80211/brcmfmac/of.c    | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> > index a7554265f95f..8ca62cd0e8ac 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
> > @@ -24,20 +24,16 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
> >  	/* Set board-type to the first string of the machine compatible prop */
> >  	root = of_find_node_by_path("/");
> >  	if (root) {
> > -		int i, len;
> >  		char *board_type;
> >  		const char *tmp;
> >  
> >  		of_property_read_string_index(root, "compatible", 0, &tmp);
> >  
> >  		/* get rid of '/' in the compatible string to be able to find the FW */
> > -		len = strlen(tmp) + 1;
> > -		board_type = devm_kzalloc(dev, len, GFP_KERNEL);
> > -		strscpy(board_type, tmp, len);
> > -		for (i = 0; i < board_type[i]; i++) {
> > -			if (board_type[i] == '/')
> > -				board_type[i] = '-';
> > -		}
> > +		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
> > +		if (!board_type)
> > +			return;
> 
> The error handling here seems to be lacking, specifically
> this error-exit path needs a of_node_put(root); call (or
> a "goto put;" or some such)

Good catch.  I will add a call to of_node_put().

regards,
dan carpenter

