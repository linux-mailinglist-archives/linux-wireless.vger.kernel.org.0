Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E096353533A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 May 2022 20:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiEZSSp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 May 2022 14:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343605AbiEZSSm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 May 2022 14:18:42 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C618BA99F
        for <linux-wireless@vger.kernel.org>; Thu, 26 May 2022 11:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xMKA54aJAAoaj8GkcafnJ5lkBPqI078hfRBM8+lexNs=;
        t=1653589120; x=1654798720; b=Y8rBpQeNyW2doMUe2rl+YzzAo/A43wEAiU8QA88Wg25+iTS
        3/xfMr4cp5F7XWibPYqyRvU/PMMuPlzSGtfJgt88GRoGvjDu6VmxRGB9oYoGjr4j7M8IcpEXMlcZ2
        RqNb5mbZP79QAfdjQmQT2dQ2hQwTqdYixzAPhJomcgEmpbs+W2sA5L67DEJgslDgqEhK9ZfEDCVKB
        1rm5gbeDa41mrnxsy4+qFYTmgwcc3RDVnJLZGgnVlrXR7y0T+TmLk5URFBjlhd+6b4Pvt6oJXF/35
        N/q/ZEcnyAXaSFOzw/MO/S9wwySw3k+5VKpcXKsnXmZLRTDE4VqWzGmA7Ovf/PhQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nuI4C-005EXY-DD;
        Thu, 26 May 2022 20:18:36 +0200
Message-ID: <d8b7572e888dd544462efdecd435742601e01517.camel@sipsolutions.net>
Subject: Re: [RFC v2 03/96] cl8k: add Kconfig
From:   Johannes Berg <johannes@sipsolutions.net>
To:     viktor.barna@celeno.com, linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>
Date:   Thu, 26 May 2022 20:18:35 +0200
In-Reply-To: <20220524113502.1094459-4-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
         <20220524113502.1094459-4-viktor.barna@celeno.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-05-24 at 14:33 +0300, viktor.barna@celeno.com wrote:
> +
> +config CL8K_VERSION
> +	string "Version"
> +	depends on CL8K
> +	default "8.1.x"
> +	help
> +	  Sets module version, which may be important for FW compatibility
> +	  analysis and syncing upstream codebase with the internal codebase.
>=20

This, along with the def.h stuff using it, and MODULE_VERSION(), is all
rather pointless, I think you should remove it.

johannes
