Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0CBD19A640
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 09:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbgDAHbQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 03:31:16 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:25561 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731879AbgDAHbP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 03:31:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585726274; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=KosNbnHtjH3p3D7s3+9XQ5MW0eKcI46fqALRBrUF8A8=; b=M/KPFLDVZ1OmpI2nzRFMvSYzvELWtyS+NLnMlT1gI1PK26mw0+3obXK3zhx8M25MQzFUDQ/2
 6XoVdgrQV8VEtSMhX/As0IwQRZz+OD6GOqXHF5F5aGk/sR3dh09Icex1ypb3yXRd7A3ZwBTF
 SAI8JsUJ9BgD4V5oQlsyF/0lKtY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e844332.7f31c0ae7650-smtp-out-n05;
 Wed, 01 Apr 2020 07:30:58 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DEE31C433D2; Wed,  1 Apr 2020 07:30:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from Pillair (unknown [183.83.66.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 427C5C433BA;
        Wed,  1 Apr 2020 07:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 427C5C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   <pillair@codeaurora.org>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1585134100-5944-1-git-send-email-pillair@codeaurora.org> <1585134100-5944-2-git-send-email-pillair@codeaurora.org> <20200331214051.GA2053@bogus>
In-Reply-To: <20200331214051.GA2053@bogus>
Subject: RE: [PATCH v2 1/3] dt-bindings: ath10k: Add wifi-firmware subnode for wifi node
Date:   Wed, 1 Apr 2020 13:00:50 +0530
Message-ID: <002001d607f7$7bc8ebd0$735ac370$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI6fc28eknFIs45cOq24ZTPq1i0fwFvI4SMAkxWCq6nfRN3kA==
Content-Language: en-us
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Rob,
Comments inline.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, April 1, 2020 3:11 AM
> To: Rakesh Pillai <pillair@codeaurora.org>
> Cc: ath10k@lists.infradead.org; linux-wireless@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 1/3] dt-bindings: ath10k: Add wifi-firmware subnode
> for wifi node
> 
> On Wed, Mar 25, 2020 at 04:31:38PM +0530, Rakesh Pillai wrote:
> > Add a wifi-firmware subnode for the wifi node.
> > This wifi-firmware subnode is needed for the
> > targets which do not support TrustZone.
> >
> > Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> > ---
> >  .../devicetree/bindings/net/wireless/qcom,ath10k.txt       | 14
> ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git
> a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> > index 71bf91f..65ee68e 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> > +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> > @@ -96,6 +96,17 @@ Optional properties:
> >  - qcom,coexist-gpio-pin : gpio pin number  information to support coex
> >  			  which will be used by wifi firmware.
> >
> > +* Subnodes
> > +The ath10k wifi node can contain one optional firmware subnode.
> > +Firmware subnode is needed when the platform does not have TustZone.
> > +The firmware subnode must have:
> > +
> > +- iommus:
> > +	Usage: required
> > +	Value type: <prop-encoded-array>
> > +	Definition: A list of phandle and IOMMU specifier pairs.
> > +
> > +
> >  Example (to supply PCI based wifi block details):
> >
> >  In this example, the node is defined as child node of the PCI
controller.
> > @@ -196,4 +207,7 @@ wifi@18000000 {
> >  		memory-region = <&wifi_msa_mem>;
> >  		iommus = <&apps_smmu 0x0040 0x1>;
> >  		qcom,msa-fixed-perm;
> > +		wifi-firmware {
> > +			iommus = <&apps_iommu 0xc22 0x1>;
> 
> Why can't you just add a 2nd entry to the existing 'iommus' property?
> 
> A driver doing of_dma_configure() is generally not the right thing to
> do.

The SIDs mentioned in the wifi-firmware node will be belonging to the
firmware and not any HLOS.
In other targets with TZ, the hypervisor takes care of configuring the SIDs
(for its master).
In this target (sc7180 IDP) we are not having TZ (no hypervisor), hence
these need to be configured by HLOS.
The wifi-firmware node is added in-order to differentiate the SID between
driver and firmware.

This is same as the approach followed by Venus video driver in the below
patch
https://patchwork.kernel.org/patch/11315765/ 

> 
> Rob
