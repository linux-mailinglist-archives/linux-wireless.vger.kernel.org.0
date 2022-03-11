Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA624D605D
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Mar 2022 12:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348026AbiCKLFh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Mar 2022 06:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbiCKLFh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Mar 2022 06:05:37 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294CE186B9B
        for <linux-wireless@vger.kernel.org>; Fri, 11 Mar 2022 03:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=tT3PmHXOIm03ht15TW/b67NPUC59dtYRiHXV8ks50d8=;
        t=1646996674; x=1648206274; b=lnhafSVRpYeIIuACKvu49wSQjtI8BRJ+XEdbfAv9JJ9VB3g
        U22fxEyKogJuC/so2EpE0ofkuYc6U1ltTRYCuIO1GtRmWiFJEyXNIjsMzuxgLeyv/H6Z25ypxgLSr
        yHGQ9sZ6bUrtcrYqFTmB6+gpO2+ZEG5SpcVp9jTNE3Vs2D8ph0Te3nrzEjRWeKwSfR7XoST06nr6q
        nrhG1BLJsxK0B7hj43HMo3Axw+xkodzyllDSAoLUujhOTl0NZ5LXmZwm0tW1RjBgJH+fR+ROjBUnC
        4o1qqUp2V0j+n/IB0ejwyFizUzp0ihbhevgc3fDkoPbOTw+8qVmVpg0SuWzONB7g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nSd4P-00BsdQ-Qo;
        Fri, 11 Mar 2022 12:04:29 +0100
Message-ID: <623add710d06dfd90291cb788756d37046ea2c74.camel@sipsolutions.net>
Subject: Re: [PATCHv2 1/6] nl80211: vendor-cmd: qca: add command for CFR
 configuration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 11 Mar 2022 12:04:28 +0100
In-Reply-To: <1645005922-7252-2-git-send-email-quic_vnaralas@quicinc.com>
References: <1645005922-7252-1-git-send-email-quic_vnaralas@quicinc.com>
         <1645005922-7252-2-git-send-email-quic_vnaralas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-02-16 at 15:35 +0530, Venkateswara Naralasetty wrote:
> Channel Frequency Response feature is to get the channel state
> information from the hardware based on the user configurations
> and send the CSI data to user space.
> 
> CSI data is further processed in user space which can be used to
> identify the motion of the objects.
> 
> Add vendor command support to configure per peer CFR parameters.
> 
> An example of usage:
> iw dev wlanx vendor send 0x1374 0xad cfr-en <val> bw <bw> method <method>
> periodicity <period> addr <mac_addr>
> 
> 0x1374: vendor id
> 0xad: : vendor subcmd id
> val: 0 to disable CFR capture
>      1 to enable CFR capture
> 
> bw: CFR capture bandwidth(use the values in enum nl80211_chan_width)
> 	1 - 20MHZ
> 	2 - 40MHZ
> 	3 - 80MHZ
> 
> method: Method used by hardware to collect the CFR dump
> 	0 - from the ACKs of QOS NULL packets
> 	1 - from the ACKs of QOS NULL packets with phase
> 	2 - from the ACK of probe response packet
> 
> periodicity: Periodicity in ms at which CFR dump need to be collect
> 	0 - single shot capture
> 	non zero - for Periodic captures
> 
> mac_addr: mac address of the peer for which CFR capture is requested.
> 
> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> ---
> v2:
>  * Updated the commit log.
> 

That's a bit better, thanks.

However, it still doesn't address the question of why it needs to be
vendor specific API.

Is this something fundamentally tied to the hardware? Fundamentally
vendor specific? I'm not sure I see why it would be?

johannes
