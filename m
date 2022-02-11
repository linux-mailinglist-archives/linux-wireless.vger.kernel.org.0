Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B954B2895
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 15:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351222AbiBKO67 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 09:58:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237878AbiBKO66 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 09:58:58 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46C3FE
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 06:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0P8Co57LELgyYLgvrjkmd/DyNYUznRvdGUQ6k9Ktkok=;
        t=1644591536; x=1645801136; b=iwuD7EWAd0rRbvrUmCc71GjloRW/M2pte2Sa32+sRmj9NZF
        pLu5hBf3wke9OW3+WN4LOHFwwK0pjQIvAEJCxFaPCidQ2R2MCPKL3FP8+Ftr+v4edjjA6boCLSyOF
        GWDuFIcU7GyDheUWgp9ShiRzSdxPeb6ezZAQwPIfQAXdfGQ+MAVvbdIU1xWXyhqL6NjhbdgftO9jQ
        7K4s78qBELQxMvA7+HfD3MrtXAm8wAWxVHuTcIs7UYqhqtvtrxhPry/JbP8obwafvWYhvrIsGiaUR
        8TIT1OybEkaMR+EvGahB2bF0lfNAOyGOC94PECCuAEMcpXdriUtW43wKkEkX68+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIXNZ-00HWWO-CD;
        Fri, 11 Feb 2022 15:58:33 +0100
Message-ID: <ebc85132546c8d7e5f62f260ccb50c73ce07c6ab.camel@sipsolutions.net>
Subject: Re: [PATCH 07/10] iwlwifi: fix leaks/bad data after failed firmware
 load
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Liu, Yongxin" <Yongxin.Liu@windriver.com>,
        "luca@coelho.fi" <luca@coelho.fi>,
        "luciano.coelho@intel.com" <luciano.coelho@intel.com>
Cc:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Fri, 11 Feb 2022 15:58:32 +0100
In-Reply-To: <PH0PR11MB51755AE791AC9BBE5B97DCF9E5309@PH0PR11MB5175.namprd11.prod.outlook.com>
References: <PH0PR11MB51755AE791AC9BBE5B97DCF9E5309@PH0PR11MB5175.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
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

On Fri, 2022-02-11 at 14:52 +0000, Liu, Yongxin wrote:
> Hi,
> 
> If there is no suitable firmware found (no firmware loaded), this patch will cause the following general protection fault.
> Please help to check.
> 
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=bea2662e7818e15d7607d17d57912ac984275d94

johannes

