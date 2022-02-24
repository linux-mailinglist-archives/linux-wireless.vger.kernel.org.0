Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E234C2266
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 04:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiBXD3N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Feb 2022 22:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBXD3M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Feb 2022 22:29:12 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740181598F5
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 19:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645673323; x=1677209323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uzaDR2DpOKs6W/KMaNLnEPWcc5zUVsz5q2VE1mDXuRw=;
  b=bRkbdb0DNiYqYiWpzPWFF25hvGGjIRtGzgdtea5kgRhbvyXEIPgbQg5W
   6G0VZxXxPFIdSsxDa7/rUSiw6ahJU4lNZ/oXLdCGAZ6HcdLFVsCvv8IfB
   ojFVSPbALi41CvUOKeNpQZs4RUFJfFvtC1gOfnSwTeIojxQAaGnfBk3IU
   w=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Feb 2022 19:28:43 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 19:28:42 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 19:28:42 -0800
Received: from qcmail1.qualcomm.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Wed, 23 Feb
 2022 19:28:39 -0800
Received: by qcmail1.qualcomm.com (sSMTP sendmail emulation); Thu, 24 Feb 2022 08:58:36 +0530
Date:   Thu, 24 Feb 2022 08:58:36 +0530
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
CC:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        <quic_usdutt@quicinc.com>
Subject: Re: [PATCH v2 1/3] cfg80211: Add NL80211_IFTYPE_MLO_LINK type for
 MLO links on MLD STA
Message-ID: <20220224032835.GA27737@CDCCSTEX0180100-LIN>
References: <1645613200-30221-1-git-send-email-quic_vjakkam@quicinc.com>
 <1645613200-30221-2-git-send-email-quic_vjakkam@quicinc.com>
 <269dcdce-ca21-211f-9f87-bc1dfc7d29b2@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <269dcdce-ca21-211f-9f87-bc1dfc7d29b2@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Feb 23, 2022 at 01:39:33PM +0100, Arend van Spriel wrote:
> On 2/23/2022 11:46 AM, Veerendranath Jakkam wrote:
> > In contrast, NL80211_IFTYPE_MLO_LINK can't be used to represent AP MLO
> > link since an MLD AP must support pre-11be and 11be clients
> > simultaneously so each AP MLO link affiliated with AP MLD must also act
> > as independent AP for pre-11be clients so each AP MLO link must be
> 
> Not just for pre-11be clients. 11be clients can opt-out right?
> 
> > represented by NL80211_IFTYPE_AP associated with a separate netdev.
> > 
> > Two link AP MLD representation:
> > 
> >                   AP MLD
> >               (netdev + wdev)
> >                  /      \
> >                 /        \
> >            wlan0          wlan1
> >        IFTYPE_AP       IFTYPE_AP
> >     (netdev + wdev)  (netdev + wdev)
> >             |             |
> >             |             |
> >          radio(2G)      radio(5G)
> 
> So the AP MLD is a new IFTYPE? Earlier discussions were suggesting the AP
> MLO links would be bridged, but then there would be only a netdev at AP MLD
> level, right?

Yes, having a separate interface type for AP MLD sound like a clean approach.
Apart from the data path, AP MLD will be involved in control path as well.
AP MLD has its own wdev. Some of the control path APIs using AP MLD
interface are link affiliation/removal, remote MLD STA add, PTK key installation,
and intra-bss forwarding configuration. Also EAPoL frames are expected on
AP MLD interface.

Vasanth
