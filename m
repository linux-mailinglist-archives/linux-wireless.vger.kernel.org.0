Return-Path: <linux-wireless+bounces-435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5B1805EC5
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 20:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC756281F4D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 19:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228516AB9A;
	Tue,  5 Dec 2023 19:46:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CEDC9;
	Tue,  5 Dec 2023 11:46:50 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id F3F9C1F8F7;
	Tue,  5 Dec 2023 20:46:48 +0100 (CET)
Date: Tue, 5 Dec 2023 20:46:43 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [EXT] Re: [PATCH v7 00/12] wifi: mwifiex: added code to support
 host mlme.
Message-ID: <ZW9+Iz9a3tEv3CpM@francesco-nb.int.toradex.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <ZWnIMGytEdDCySS8@francesco-nb.int.toradex.com>
 <PA4PR04MB9638E6F1128DE4ED977E0D07D181A@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9638E6F1128DE4ED977E0D07D181A@PA4PR04MB9638.eurprd04.prod.outlook.com>

On Fri, Dec 01, 2023 at 11:05:47PM +0000, David Lin wrote:
> > On Tue, Nov 28, 2023 at 04:31:03PM +0800, David Lin wrote:
> > > 5. Address reviewer comments.
> > You should list the changes you did, something that generic is forcing the
> > reviewer to compare v7 vs v6 to known what changed.
> 
> Can I summary what should I do and hopefully I can make agreement with you:
> 
> 1. Separate patch v7 6/12 as a single patch.
> 2. Merged all other patches as a single patch for host mlme.

I would suggest to proceed the following way:

 1. v8 of this series should have only 2 patches
   - PATCH v8 1/2 : add host mle station support.
   - PATCH v8 2/2 : add host mle AP support.

   Any kind of fix on these 2 new functionalities should be squashed in
   these single 2 patches. No commit to add a functionality with a bug
   that is fixed with a follow-up commit. If you discover bugs during
   your testing this is great, just amend the original commit that
   introduced it.

   I am assuming that is fair to implement station and AP support in
   separated patches, please speak up if this is not the case.

 2.  PATCH v7 06/12: this should be send as a new separate patch, with a
     Fixes: tag and Cc:stable. 

> So there should be no patch v8 and only have two patches, one for host
> mlme and another one to fix hostap restart issue.

It's ok to have a v8, restarting another series will be even more
confusing IMO.


Thanks!

Francesco


