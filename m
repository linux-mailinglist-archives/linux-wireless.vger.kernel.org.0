Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67186DBFE8
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 10:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395523AbfJRIaE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 04:30:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50146 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727573AbfJRIaE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 04:30:04 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLNe6-00021V-24; Fri, 18 Oct 2019 11:30:02 +0300
Message-ID: <bd880fbb741f6ee38d89e2a58343b42590344ca1.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 18 Oct 2019 11:30:01 +0300
In-Reply-To: <87pnixkw2k.fsf@codeaurora.org>
References: <20191014072019.1254-1-luca@coelho.fi>
         <20191014101813.7e2742c1e22f.I65d0d5e782864f53b4ed8a6f43e72c50a09d9fd9@changeid>
         <87pnixkw2k.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v2 12/16] iwlwifi: dbg_ini: support domain changing via
 debugfs
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-10-16 at 10:07 +0300, Kalle Valo wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > From: Shahar S Matityahu <shahar.s.matityahu@intel.com>
> > 
> > Allow to change or read the debug domain bitmap at runtime via
> > fw_dbg_domain debugfs.
> > 
> > Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> 
> [...]
> 
> > +static ssize_t iwl_dbgfs_fw_dbg_domain_write(struct iwl_fw_runtime *fwrt,
> > +					     char *buf, size_t count)
> > +{
> > +	u32 new_domain;
> > +	long val;
> > +	int ret;
> > +
> > +	if (!iwl_trans_fw_running(fwrt->trans))
> > +		return -EIO;
> > +
> > +	ret = kstrtol(buf, 0, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	new_domain = (u32)val;
> 
> Why not use kstrtou32()? Then there's no need to cast anything.

Good point, I'll fix it.

--
Luca.

