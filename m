Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 537E8FAC60
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 09:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfKMIxb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 03:53:31 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:56656 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725993AbfKMIxb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 03:53:31 -0500
Received: from [134.191.232.92] (helo=dubbel)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iUoP2-0005pW-CR; Wed, 13 Nov 2019 10:53:29 +0200
Message-ID: <ee020a76f296a2d083eb203d1b96ee6d4900c4e9.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 13 Nov 2019 10:53:26 +0200
In-Reply-To: <87v9sdp8rz.fsf@kamboji.qca.qualcomm.com>
References: <20191019093902.29823-1-luca@coelho.fi>
         <20191019093902.29823-2-luca@coelho.fi>
         <87v9sdp8rz.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 03/12] iwlwifi: nvm: update iwl_uhb_nvm_channels
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-10-25 at 10:46 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Tova Mussai <tova.mussai@intel.com>
> > 
> > Update uhb channels numbers to start from 1
> > 
> > Signed-off-by: Tova Mussai <tova.mussai@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> Why?

Hi,

Just coming back to this now, sorry.  I'll rephrase this and send v2.

--
Cheers,
Luca.

