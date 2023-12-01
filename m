Return-Path: <linux-wireless+bounces-289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4316800A10
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 12:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 735F8B20E48
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 11:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590882135D;
	Fri,  1 Dec 2023 11:49:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B931170E;
	Fri,  1 Dec 2023 03:49:08 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 264AC20645;
	Fri,  1 Dec 2023 12:49:06 +0100 (CET)
Date: Fri, 1 Dec 2023 12:49:04 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v7 00/12] wifi: mwifiex: added code to support host mlme.
Message-ID: <ZWnIMGytEdDCySS8@francesco-nb.int.toradex.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128083115.613235-1-yu-hao.lin@nxp.com>

Hello Lin,
thanks for the patches here, I can clearly see that this code is going
through some real testing given the improvements you did lately.

I have commented on the single patches, and honestly I did not look into
the code details at the moment.

The major feedback from me is the following:
 1 - you should not add code with a bug and than fix a bug in the same
     series, you should have a non buggy patch in the first place (e.g.
     git --amend). (this applies till the patch is not merged into the
     maintainer tree, of course).
 2 - point 1 applies also to reviewer comments
 3 - if you have fixes that are not connected to the feature addition
     you are doing is beneficial to have those separated, this makes
     reviewing easier, they can be "prioritized" to some extent (given
     that they are fixes) and follow a slightly different patch flow
     (they can get applied, depending on the maintainers decision, when the
     merge window is closed and should be backported). Not to mention
     that smaller patch series are appreciated, "Maximum of 7-12 patches
     per patchset " from [1]

In general I would suggest you to have a look at [1], not sure how up to
date is that compared to the in-tree Documentation/process/.

On Tue, Nov 28, 2023 at 04:31:03PM +0800, David Lin wrote:
> 5. Address reviewer comments.
You should list the changes you did, something that generic is forcing
the reviewer to compare v7 vs v6 to known what changed.


[1] https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

Francesco


