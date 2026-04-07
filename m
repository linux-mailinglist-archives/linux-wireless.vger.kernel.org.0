Return-Path: <linux-wireless+bounces-34449-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIxvDGyo1GmkwAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34449-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 08:47:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEEA3AA728
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 08:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ED87309B9B7
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 06:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4000038B132;
	Tue,  7 Apr 2026 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZjh3z+o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE238A712;
	Tue,  7 Apr 2026 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544241; cv=none; b=qbPFDIBZWCs3O3ap4neIFG9gKgNs2K4N0VRT2NuolqJasiLbsBf3D5NAzJPyTewvPx/wuEBJAhNXd6Devt8oV5RrFP64HkSoCekC9lbcOXTbxBq+nmsJ1WVPG0Ur/wMc/tgVWjI0mQOOLkzzP1bQBFnCX+FCJ2J2FgP6HEkcmkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544241; c=relaxed/simple;
	bh=To0TOgWdk+Eg3vCUJ0MvI1sSRqScB4zFZ3xj+H7iwWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nCPEpFH0FOA7T08s4JZROz9NGFI1FEVulcdOSPaqkybxmvoRpSmJJjGN0JF5wC24znSHqlw95d7w4juLoXnEDZPZvnDvbehTTYZj0aGoHH+r+rVP95KsxQMAVu7JyjqqvREg9Ux7Kg32iOZLkiC78/gbWL+WB5xtHxNqD6LBAfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZjh3z+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD69CC19424;
	Tue,  7 Apr 2026 06:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775544240;
	bh=To0TOgWdk+Eg3vCUJ0MvI1sSRqScB4zFZ3xj+H7iwWk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LZjh3z+oKpl3+fFSh3fpCOIeXeEibbIAZ45Tgut4/0L/2VtEpuqkd/hV4xtxpTlOh
	 cLOataclZiWmnVO3IfQErs9jpIl7IEmDGlk0VHqBQh2aLB/KVkhlwGHQFq1N3ABBy3
	 TQIEg+oURUJrG2/4PWittvzZEYw+AHGJSiEASktUgCWSA6yTnYNfAgoeUZiH5PBeOB
	 e8wYJM1toLafK4tHjGT/TASxIqpz4dTOBYeiaqIR2f8sEItLE5m26kFo0Qk6GSmIMp
	 yW/MdmNbFGrsra4/hHrYIsEOW1tVz1R9U2IrMLDull3Qhv7/+xj6TjSefd+fLTEI+i
	 DWiXaQ0S530+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE07E9D832;
	Tue,  7 Apr 2026 06:44:00 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 07 Apr 2026 08:43:56 +0200
Subject: [PATCH v5 3/3] arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable
 ath10k host-cap skip quirk
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-skip-host-cam-qmi-req-v5-3-dfa8a05c6538@ixit.cz>
References: <20260407-skip-host-cam-qmi-req-v5-0-dfa8a05c6538@ixit.cz>
In-Reply-To: <20260407-skip-host-cam-qmi-req-v5-0-dfa8a05c6538@ixit.cz>
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Paul Sajna <sajattack@postmarketos.org>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, 
 Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Amit Pundir <amit.pundir@linaro.org>, linux-wireless@vger.kernel.org, 
 devicetree@vger.kernel.org, ath10k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=DU/dXePFyTa55SQv+lhHqY4KIdvjaGH0tSQ5egVr5Ig=;
 b=kA0DAAgBYAI/xNNJIHIByyZiAGnUp66g1k1G2PXK1XLApKqh8rZQqnP+rM1X6ccdHnoc1CQiZ
 YkCMwQAAQgAHRYhBNd6Cc/u3Cu9U6cEdGACP8TTSSByBQJp1KeuAAoJEGACP8TTSSByrA0P/3wf
 qabD5CEeb4B4+PsJgKOZY/BrgJN1A4Zdw5C35f3dwpNPtBQTwOkxEcSCHj5GYoAtZRGeJWCr+0Z
 6Za616Xc2FfWBQa3wtnFtArLaTN58RK4j9patgL5m1lOe+iXo9A8ZyowzTRgnLA3jvxqfibnXdU
 Cab7tJzP2IyopQE4WpkfMYjj6PbA72EmXSMtVqBpPr73FIyYL1rSswZ52gOxhVIGOx6SAaZg+4c
 KsKnhg03Fzx7Y3UKTFqJ2JYMadV/h+GgmL4PfmYQqcLUtEcMm8BBRPiVFKGproGfkJ6hDA59JFH
 CVwyIV3QEC8op9GElbGGXsiAq0XbBFo+qvLme+gDcpTakvz1EzLv/bfYG+SPP9K4a1LlklC5Ehl
 AX+zAk15id1qDONaAxEvMqmb3cGD13a+fh+2UIdFC85hqzpGzUYqUZR1HtQmwu00VcA40aMZ1OC
 2YgTBb6/gn82TMc4560FcTrUfrifRtAe1/jzgA1JvZsFhZHb+cCT2TqqduU7OmB4HfUxlWW/dm+
 776t78Z0IxeMPAMYeg2sSjUubPOWtuRYWn1A/dpuXxY2+75D6wlD/mukE0f+FzRdqVIQ8zImbK9
 fxQTk8iTFc8OkBhZ6pTMXKdAKOP5igNOcTaLWDJlAmQ74V63pcGF7c3fFwrZU38fc94/eSp9NM8
 hmeoN
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34449-lists,linux-wireless=lfdr.de,david.ixit.cz];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[david@ixit.cz];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,ixit.cz:email,ixit.cz:replyto,ixit.cz:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: CAEEA3AA728
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Amit Pundir <amit.pundir@linaro.org>

The Wi-Fi firmware used on Xiaomi Poco F1 (beryllium) phone doesn't
support the host-capability QMI request, so add a quirk to skip it on
this device.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 1298485c42142..950bbcc3bf91f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -661,5 +661,6 @@ &wifi {
 	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
 
 	qcom,calibration-variant = "xiaomi_beryllium";
+	qcom,snoc-host-cap-skip-quirk;
 };
 

-- 
2.53.0



